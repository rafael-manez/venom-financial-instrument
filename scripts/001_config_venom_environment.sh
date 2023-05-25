#!/bin/bash
#Config environment for smartcontract on financial instruments
clear
echo '' 
echo '******************************** CONFIG ENVIRONMENT FOR SMART CONTRACT FOR FINANCIAL INSTRUMENT *********************************************************'
echo ''

WORK_SPACE="$1"
PROJECT_NAME='venom-financial-instruments'
PROJECT_NAME_INSTRUMENT="$2"
VENOM_HOME="/home/venom"
function usage()
{
  echo ''
  echo 'Usage: ./001_config_venom_environment.sh "$WORK_SPACE" "PROJECT_NAME_INSTRUMENT"'
  echo "Brief: install and config docker, node, yarn, npm, locklift and wokspace at default $WORK_SPACE/$PROJECT_NAME"
  echo ' 1.# chmod a+x 001_config_venom_environment.sh'
  echo ' 2.# WORK_SPACE="/mnt/usb/venon/venom-financial-instruments' #work space should have the word venom-financial-instruments
  echo ' 3.# PROJECT_NAME_INSTRUMENT="companyShares"'
  echo ' 4.# ./001_config_venom_environment.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT"'
  echo '' 
}

echo "executing... ./001_config_venom_environment.sh \"$WORK_SPACE\" \"$PROJECT_NAME_INSTRUMENT\""
#Create home and passs or w
if [[ $(whoami) == "venom" ]]; then 
  echo "venom home exist";
  cd --
else 
  echo "No Venom"; 
  sudo adduser venom
  sudo usermod -aG sudo venom #add to sudo group
fi
sync
#Check script parameters
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
if [ -d "$WORK_SPACE/$PROJECT_NAME_INSTRUMENT" ]; then
  echo "Error: The project exists. If you want to update. It is recommended to use an auxiliary worksapace and update to the new code from there to prevent applyng changes to existing code."
  usage
  exit 1
fi


#Install require packages
sudo apt update

#sudo apt upgrade 
sudo apt install gcc g++ make cmake tree
sudo apt install cargo #solidity TMV linker
sudo apt install ca-certificates curl gnupg

#config Docker
if ! [[ $(docker --version) =~ '23.'.* ]]; then 
 #sudo apt purge docker docker-engine docker.io containerd runc
 curl -fsSL https://get.docker.com -o get-docker.sh
 sudo chmod a+x get-docker.sh
 #sudo sh ./get-docker.sh --dry-run
 sudo sh ./get-docker.sh 
 sudo rm get-docker.sh
fi


#Config Node
if ! [[ $(node -v) =~ 'v19'.* ]]; then 
 curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt install -y nodejs
fi

#Install Yarn package managet
if ! [[ $(yarn -v) =~ '1.22.'.* ]]; then 
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install yarn
  yarn -V
fi

#Install TON-solidity-Compiler
if [ ! -n $(which tvm_linker) ] || ! [[ $( solc -v) =~ .*'0.68.'.* ]]; then
  echo "Install or Updating TON-solidity-Compiler"	
  git clone https://github.com/tonlabs/TON-Solidity-Compiler ${VENOM_HOME}/TON-Solidity-Compiler
  sh ${VENOM_HOME}/TON-Solidity-Compiler/compiler/scripts/./install_deps.sh
  mkdir ${VENOM_HOME}/TON-Solidity-Compiler/build
  cd ${VENOM_HOME}/TON-Solidity-Compiler/build
  cmake ${VENOM_HOME}/TON-Solidity-Compiler/compiler/ -DCMAKE_BUILD_TYPE=Release
  cmake --build . --target install --config Debug -j$(nproc)
  #cmake --install . --config Debug
  sudo -u venom sh ${VENOM_HOME}/TON-Solidity-Compiler/compiler/scripts/install_lib_variable.sh #Envar venom Environment
  cd --
fi

#Install LINKER
tvm_linker_version=$(tvm_linker -V | grep -E 'v[.0-9]+')
if [ ! -n $(which tvm_linker) ] || ! [[ $( tvm_linker -V) =~ .*'0.20.'.* ]]; then 
  echo "Install or Updating TMV_LINKER"
  git clone https://github.com/tonlabs/TVM-linker.git ${VENOM_HOME}/TVM-linker
  cd ${VENOM_HOME}/TVM-linker
  echo "NOTICE: Please be patient with the download and update process. If,it takes more than 5 minutes, restart the script until reaches a fast index node"
  cargo update && cargo build --release -j$(nproc)
  echo "Add linker to PATH permanently at ${VENOM_HOME}/.bashrc and create tvm_linker alias"
  echo "export TVM_LINKER_PATH=${VENOM_HOME}/TVM-linker/target/release/tvm_linker" >> ${VENOM_HOME}/.bashrc
  echo "alias tvm_linker=$TVM_LINKER_PATH" >> ${VENOM_HOME}/.bashrc #is a script set as alias
  alias tvm_linker=$TVM_LINKER_PATH
  source ~/.bashrc #refres environment
  tvm_linker_version=$( ${VENOM_HOME}/TVM-linker/target/release/./tvm_linker -V | grep -E 'v[.0-9]+')
  echo "TVM LINKER New Version: $tvm_linker_version"
  cd --
fi

#Dowload tonlabs local docker environemnt
tonlabs_local_node=$(sudo docker ps | grep tonlabs/local-node)
if [[ -n $tonlabs_local_node ]]; then 
  echo "Tonlabs docker local-node"
  docker ps | grep tonlabs/local-node
else	
  docker run -d -e USER_AGREEMENT=yes --rm --name local-node -p80:80 tonlabs/local-node:0.29.1
  echo $tonlabs_local_node 
fi
version_tonlabs_local_node=$(sudo docker ps | grep -Eo "tonlabs/local-node:[.0-9]+")

#Check npm locklift package
if ! [[ $( npm list -g | grep locklift ) =~ .*'2.5.5'.* ]]; then 
  npm install -g locklift
fi

#Setting up the venom smart contract development environment
if ! [ -d  "$workSpace/${PROJECT_NAME_INSTRUMENT}" ]; then 
  echo "Initial project ......"
  locklift init --path $WORK_SPACE/${PROJECT_NAME_INSTRUMENT}
fi

echo "SUMMARY________________________________"
echo " node -v ..................: $(node -v)"
echo " yarn -v ..................: $(yarn -v)"
echo " npm -v  ..................: $(npm -v) "
echo " docker --version .........: $(docker --version )"
echo " cmake --version ..........: $(cmake --version | tr '\n' ' ')"
echo " TON-Solidity-Compiler.....: $(solc -v | tr '\n' ' ')"
echo " tvm_linker -V.............: $tvm_linker_version"
echo " docker tonlabs/local-node.: $version_tonlabs_local_node"
echo " cargo --version...........: $(cargo --version)"
echo " locklift --version........: $(locklift --version)"
echo " PATH TO PROJECT...........: cd ${VENOM_HOME}/$WORK_SPACE/${PROJECT_NAME_INSTRUMENT}"
echo " Tree project..............: tree --gitignore ${VENOM_HOME}/$WORK_SPACE/${PROJECT_NAME_INSTRUMENT}"
echo "_______________________________________"
echo " "

sync
if [[ $(whoami) == "venom" ]]; then 
  cd --
else
  sudo su venom
fi
