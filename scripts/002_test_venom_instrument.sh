#!/bin/bash
#Config environment for smartcontract on financial instruments
clear
echo '' 
echo '******************************** TEST INANCIAL INSTRUMENT SMART CONTRACT *********************************************************'
echo ''

WORK_SPACE="$1"
PROJECT_NAME='venom-financial-instruments'
PROJECT_NAME_INSTRUMENT="$2"
CONFIG_FILE_ENVIRONMENT="${3-unset}"
CONTEXT_ENVIRONMENT="${4-local}" #local=local-node | testnet=tesnet.venom   | mainnet=?.venom

function usage()
{
  echo ''
  echo 'Usage: ./002_test_venom_instrument.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT" "[$CONTEXT_ENVIRONMENT]"'
  echo "Brief: Test instrument by locklift at defaul wokspace $WORK_SPACE/$PROJECT_NAME with config file for dev at .env and default context to launch docker/local-hode of [local|testnet|mainnet]"
  echo ' 1.# chmod a+x 002_test_venom_instrument.sh'
  echo ' 2.# eval $(ssh-agent -s); ssh-add ~/.ssh/venom_rsa; ssh -T git@github.com	#Active git agent to interact with live user' #set up git interaction
  echo ' 3.# WORK_SPACE="/mnt/usb/venon/venom-financial-instruments	#work space should have the word venom-financial-instruments'
  echo ' 4.# PROJECT_NAME_INSTRUMENT="companyShares"'
  echo ' 5.# CONFIG_FILE_ENVIRONMENT=".env"	#If not exists create with "·ouch .nv"'
  echo ' 6.# CONTEXT_ENVIRONMENT="local"	#Context to launch [local | testnet | mainnet]  Default 'local' launch docker/local-node'
  echo ' 7.# ./002_test_venom_instrument.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT" "$CONFIG_FILE_ENVIRONMENT"'
  echo ''
  echo 'Example:'  
  echo '  WORK_SPACE="/home/venom/venom-financial-instruments/"; PROJECT_NAME_INSTRUMENT="companyShares"; CONFIG_FILE_ENVIRONMENT=".env"; CONFIG_FILE_ENVIRONMENT="local"; ./scripts/002_test_venom_instrument.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT "$CONFIG_FILE_ENVIRONMENT"'
}

echo "executing... ./002_test_venom_instrument.sh \"$WORK_SPACE\" \"$PROJECT_NAME_INSTRUMENT\" \"$CONFIG_FILE_ENVIRONMENT\" \"$CONTEXT_ENVIRONMENT\""

#Exist work space?
if ! [[ "${WORK_SPACE}" =~ .*"${PROJECT_NAME}".* ]] ; then 
  echo "Error: I need a work space to build project $PROJECT_NAME with $PROJECT_NAME in path"
  echo "       eq. WORK_SPACE/$PROJECT_NAME/companyShares"
  usage
  exit 1
fi

if [ -z "${WORK_SPACE}" ]; then 
  echo "Error: I need a work space to build project $PROJECT_NAME"
  echo "       eq. WORK_SPACE/$PROJECT_NAME/companyShares"
  usage
  exit 1
fi

#Exist instrument?
if ! [ -d "$WORK_SPACE/$PROJECT_NAME_INSTRUMENT" ]; then
  echo "Error: The project not exists at $WORK_SPACE/$PROJECT_NAME_INSTRUMENT ..."
  usage
  exit 1
fi

#Load var to System ENVIRONMENT instead of 'import dotenv from "dotenv"; dotenv.config()
#Exist config file .env? 
if [ -f "$WORK_SPACE/$PROJECT_NAME_INSTRUMENT/.env" ]; then
  echo "Loading config file intrument environment at $WORK_SPACE/$PROJECT_NAME_INSTRUMENT/.env" 
  source <(sed -e '/^$/d' -e '/^#/d' -e 's/.*/declare -x "&"/g'  $WORK_SPACE/$PROJECT_NAME_INSTRUMENT/.env)  #as export, poblate .env with  variable=value
else
  echo "Error: Config File .env Not Exist at $WORK_SPACE/$PROJECT_NAME_INSTRUMENT/.env. Set PATH to '.env' , 'export VARIABLE=VALUE' or create 'touch .env'"
  usage
  exit 1
fi

#Exists Context environment? [local|testnet|mainnet]
if [[ "${CONTEXT_ENVIRONMENT}" =~ local|testnet|mainnet ]] ; then
  echo "CONTEXT_ENVIRONMENT: $CONTEXT_ENVIRONMENT"
  if [[ "${CONTEXT_ENVIRONMENT}" =~ 'local' ]]; then
    tonlabs_local_node=$(sudo docker ps | grep tonlabs/local-node)
    if [[ -n $tonlabs_local_node ]]; then 	
      echo "Local docker node $tonlabs_local_node is up to date"
    else
      sudo docker run -d -e USERVER_AGREEMENT=yes --rm --name local-node -p80:80 tonlabs/local-node:0.29.1
    fi
    version_tonlabs_local_node=$(sudo docker ps | grep -Eo "tonlabs/local-node:[.0-9]+")
  fi
else
  echo "ERROR: CONTEXT_ENVIRONMENT: $CONTEXT_ENVIRONMENT not exists. Only [local | testnet | mainnet]. local=local-node | testnet=tesnet.venom   | mainnet=?.venom"
fi

#RUN CONTEXT Project
if [ -d  "$WORK_SPACE/${PROJECT_NAME_INSTRUMENT}" ]; then
  echo "Launch $PROJECT_NAME_INSTRUMENT $CONTEXT_ENVIRONMENT environment at $WORK_SPACE/${PROJECT_NAME_INSTRUMENT}" 
  cd  $WORK_SPACE/${PROJECT_NAME_INSTRUMENT} 
  case $CONTEXT_ENVIRONMENT in
    "local")	  
       locklift test --network local --config $WORK_SPACE/${PROJECT_NAME_INSTRUMENT}/locklift.config.ts --disable-include-path 
       ;;
    "testnet")
       echo ""	    
       echo "Notice:"
       echo "Testnet is private. Will be released soon."
       echo ""
       ;;
    "mainnet")
       echo "Mainnet is private"
       ;;
  esac
else
  echo "ERROR PROJECT  NOT EXIST $WORK_SPACE/${PROJECT_NAME_INSTRUMENT} ......"
  usage
  exit 1
fi

echo "SUMMARY________________________________"
echo " node -v ..................: $(node -v)"
echo " yarn -v ..................: $(yarn -v)"
echo " npm -v  ..................: $(npm -v) "
echo " docker --version .........: $(docker --version )"
echo " cmake --version ..........: $(cmake --version | tr '\n' ' ')"
echo " config file .env..........: $WORK_SPACE/$PROJECT_NAME_INSTRUMENT/.env"
echo " TON-Solidity-Compiler.....: $(solc -v | tr '\n' ' ')"
echo " tvm_linker -V.............: $($TVM_LINKER_PATH -V | grep -Eo 'v[.0-9]+')" #chain to inline shell alias echo $(tvm_linker -V | grep -Eo 'v[.0-9]+')"
echo " docker tonlabs/local-node.: $version_tonlabs_local_node"
echo " cargo --version...........: $(cargo --version)"
echo " locklift --version........: $(locklift --version)"
echo " PATH TO PROJECT...........: cd $WORK_SPACE/${PROJECT_NAME_INSTRUMENT}"
echo " Tree project..............: tree --gitignore $WORK_SPACE/${PROJECT_NAME_INSTRUMENT}"
echo "_______________________________________"
echo " "

