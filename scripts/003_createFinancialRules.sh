

#!/bin/bash
#****************************************************** ECHO COLORS ******************************************************
red='\e[0;31m'
NC='\e[0m' # No Color
#****************************************************** USAGE ************************************************************
function usage
{
  echo 
  echo 'NAME: 003_createFinancialRules.sh'
  echo 'brief:  Create financial rules specification for authorities, region and main financial rules book, install open api, create cli/server/web3connet to auto code'
  echo 'usage: ./003_createFinancialRules.sh [--install install:openap] [--to_workdir] [--create_authority_json_yaml_metadata_specification]'
  echo ' 1.- Install from bash .............................................................................................'
  echo '	./003_createFinancialRules.sh --install install:openapi --to_workdir ~/venom-financial_instruments/ --version 6.6.0 --to_address /bin'
  echo 
  echo ' 2.- Create a main rules book specification [JSON|YAML] for all financial and compatible regions ...................'
  echo '	WORK_SPACE=~/venom-financial-instruments/metdata/specification/v1'
  echo '        REGION="ALL" #[ALL,EU,EU/LU,EU/FR,UAE,UAE/AZ,US/NY]'
  echo '        FINANCIAL_AUTHORITY="Authorities" #[Authorities,ESMA,SEC,ESCA,CNA_SP,CNA_NY]'
  echo '        FINANCIAL_INSTRUMENT="rulesBook.yaml"'
  echo '	./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification  --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"'
  echo  
  echo ' 3.- Create a iso region authority for instruments from DLT MI tool.................................................'
  echo '	WORK_SPACE=~/venom-financial-instruments/metadata/specification/v1'
  echo '        REGION="EU" #[EU,EU/LU,EU/FR,UAE,UAE/AZ,US/NY]'
  echo '        FINANCIAL_AUTHORITY="ESMA" #[ESMA,SEC,ESCA,CNA_SP,CNA_NY]'
  echo '        FINANCIAL_INSTRUMENT="companyShares.yaml"  #[companyShares.yaml, bonds.yaml, derivates.yaml...]'
  echo '	./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"'
  echo  
  echo ' 4.- Generate openapi Client models, Server API, markdown and html documents .......................................'
  echo ' 	WORK_SPACE=~/venom-financial-instruments/'
  echo ' 	TOOLS_DIR=/bin/openapitools'
  echo '	FROM_ADDRESS=~/venom-financial-instruments/metadata/specification/v1/EU/ESMA/companyShares.yaml'  
  echo ' 	TO_ADDRESS=/metadata/api/EU/ESMA/'
  echo '	./003_createFinancialRules.sh --generator generator::python3 --to_workdir "$WORK_SPACE" --tools_dir "$TOOLS_DIR" --from_address "$FROM_ADDRESS" --to_address "$TO_ADDRESS"'
  echo 
  echo ' 5.- Run servers.'
  echo '       server API.: cd $WORK_SPACE/$TO_ADDRESS/python/; python3 -m openapi_server'
  echo '       api endpoint: http://localhost:8080/api/v1'
  echo '       server doc.: sudo python3 -m http.server --directory $WORK_SPACEi/doc/api/v1/ 80'
  echo '       doc out....: http://localhost:8080/doc/api/v1'
  echo 
  echo ' Test ............................................................................. ./003_createFinancialRules.sh --test'
  echo ' Remote usage ..................................................................... ssh user@192.168.3.113 ''''echo password | sudo -Sv && bash -s sudo'''' < ./003_createFinancialRules.sh --generate ...'
  echo
  echo  
  echo 'Examples.......................................................................................................'
  echo ' Install Open Api and tools'
  echo ' 	./003_createFinancialRules.sh --install install:openapi --to_workdir ~/venom-financial_instruments --version 6.6.0 --to_address /bin'
  echo ' Create rulebook.yaml specification for all authorities'
  echo '       WORK_SPACE=~/venom-financial-instruments/metadata/specificacion/v1; REGION="ALL"; FINANCIAL_AUTHORITY="Authorities"; FINANCIAL_INSTRUMENT="rulesBook.yaml";'
  echo '       ./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"'
  echo ' Create competent authorities'
  echo '       WORK_SPACE=~/venom-financial-instruments/; TOOLS_DIR="/bin/openapitools"; FROM_ADDRESS=~/venom-financial-instruments/metadata/specificacion/v1/EU/ESMA/companyShares.yaml; FINANCIAL_INSTRUMENT="companyShares.yaml";' 
  echo '       ./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"'
  echo ' Create Server and Client stubs from financial instrument specification'
  echo '        WORK_SPACE=~/venom-financial-instruments/; TOOLS_DIR="/bin/openapitools"; FROM_ADDRESS=~/venom-financial-instruments/metadata/specificacion/v1/EU/ESMA/companyShares.yaml; TO_ADDRESS="/metadata/api/EU/ESMA";'
  echo '        ./003_createFinancialRules.sh --generator generator::python3 --to_workdir "$WORK_SPACE" --tools_dir "$TOOLS_DIR" --from_address "$FROM_ADDRESS" --to_address "$TO_ADDRESS"'
  echo ' Run SERVERS'
  echo '       cd $WORK_SPACE/$TO_ADDRESS/python/; python3 -m openapi_server #http://localhost:8080/api/v1'
  echo '       sudo python3 -m http.server --directory $WORK_SPACEi/doc/api/v1/ 80 #http://localhost:8080/doc/api/v1'
  echo ''
}

#Install package
if [ ! -n $(which pip3) ]; then
  sudo apt install python3-pip #install for server client
fi
	
#****************************************************** GET OPTION ********************************************************
to_workdir=unset #source code place
tools_dir=unset
install=unset
generator=unset
from_address=unset
to_address=unset
project_name='venom-financial-instruments'
region=unset
financial_authority=unset
name_instrument=unset
create_authority_json_yaml_metadata_specification=unset
api_version='v1'

_TEST='off'
_LOG='on'

#NOTE if use remote script change $1 -> $2
if [ $# -lt 1 ]; then usage; echo "$# .Need param."; exit 1; fi
while [ "${1:-unset}" != "unset" ]; do
  case "${1:-unset}" in  #$2 o $1
    --install )
      shift
      install=${1:-unset}
      echo -e "${red}Parameter 1 equals --install $1${NC}"
      ;;
    --generator )
      shift
      generator=${1:-unset}
      echo -e "${red}Parameter 1 equals --generator $1${NC}"
      ;;
    --to_workdir )
      shift
      to_workdir=${1:-unset}
      echo -e "${red}Parameter 1 equals --to_workdir $to_workdir${NC}"
      ;;
    --tools_dir )
      shift
      tools_dir=${1:-unset}
      echo -e "${red}Parameter 1 equals --tools_dir $tools_dir${NC}"
      ;;
    --from_address )
      shift
      from_address=${1:-unset}
      echo -e "${red}Parameter 1 equals --from_address $1${NC}"
      ;;
    --to_address )
      shift
      to_address=${1:-unset}
      echo -e "${red}Parameter 1 equals --to_address $1${NC}"
      ;;
    --create_authority_json_yaml_metadata_specification )
      #shift 
      create_authority_json_yaml_metadata_specification="ON" 
      echo -e "${red}Parameter 1 equals --create_authority_json_yaml_metadata_specification $create_authority_json_yaml_metadata_specification${NC}"
      ;;
    --region )
      shift
      region=${1:-unset}
      echo -e "${red}Parameter 1 equals --region $1${NC}"
      ;;
    --financial_authority )
      shift
      financial_authority=${1:-unset}
      echo -e "${red}Parameter 1 equals --financial_authority $1${NC}"
      ;;
    --name_financial_instrument )
      shift
      name_financial_instrument=${1:-unset}
      echo -e "${red}Parameter 1 equals --name_financial_instrument $1${NC}"
      ;;
    --version )   
      shift
      version=${1:-unset}
      echo -e "${red}Parameter 1 equals --version $1${NC}"
      ;;
    --remove )
      #shift
      remove=$1
      echo -e "${red}Parameter 1 equals --remove $1${NC}"
      ;;
    --test )
      _TEST='on'
      echo -e "${red}Parameter 1 equals --test $_TEST${NC}"
      ;;
    -h | --help )           
      usage
      exit
      ;;
    * )             
      usage
      exit 1
  esac
  shift
done
echo 
#*************************************************** FUNCTIONS ***************************************************
declare -a summary_list
function summary::add()
{
  #example summary::add "log summary: openapi-generator-cli version .............................................: ${version}"
  to_summary="${1:-unset}"
  summary_list+="${to_summary}\n"
}

function summary::read()
{
  for ix in ${!summary_list[*]}
  do
    echo -e "${summary_list[${ix}]}"
  done
  unset summary_list
}

#show summary of stats
function summary()
{
  protocol='http'
  server_name='192.168.1.107'
  echo "*****************************************************************************************************************"
  echo ""
  #usage
  echo ""
  echo "Summary :"
  echo -e ""
  echo -e "log summary: Root APP...........................................................: cd $to_workdir"
  summary::read
  echo -e "${red}******************************************* GO ON URL *********************************************${NC}"
  echo -e "${red}sudo python3 -m http.server --directory $to_workdir/$to_address 80  #start server${NC}"
  echo -e "${red}$to_workdir > ${protocol}://localhost/${to_address}/  "
  echo -e "${red}$to_workdir > ${protocol}://${server_name}/${to_address}/ ${NC}"
  echo -e "${red}Executed by ${0##*/} from ${0}${NC}"
  echo -e "${red}***************************************************************************************************${NC}"
  echo ""
  echo "*************************************************************************************************"
}


##Create path to instrument metadat

function create::authority()
{
  echo -e "${red} Creating authority $to_workdir${NC}"
  local to_address=${to_address//\//} #remove intial /dir to resolve ambiguity with root_dirs
  local to_workdir=$to_workdir
  if [[ $to_workdir == 'unset' ]]; then echo "log Error: Empty --to_workdir [path_metadata] "; exit; fi
  if [[ $region == "unset" ]]; then echo "log Error: Empty financial region as iso name as ['UE'|'UE/LU'|'US'|'US/NY'] --region [iso_region]"; exit; fi
  if [[ $financial_authority == "unset" ]]; then echo "log Error: Empty financial authority as [ESMA|SEC|ESCA] --financial_authority [financial_authority_acronym]"; exit; fi
  if [[ $name_financial_instrument == "unset" ]]; then echo "log Error: Empty name of financial instrument schema [financial_instrument_name[.json|.yaml]]"; exit; fi
  if ! [ -f $to_workdir/$region/$financial_authority/$name_financial_instrument ]; then 
    mkdir -p  $to_workdir/$region/$financial_authority/
    touch $to_workdir/$region/$financial_authority/$name_financial_instrument  
    summary::add "log summary: Financial Instruments Metadata File for create rules at .............................................: $to_workdir/$region/$financial_authority/$name_financial_instrument"
  else
    echo "log Error: The instruments $name_financial_instrument exists at authority $region/$financial_authority. Change instrument name or create a new authority."
    usage
    exit 1
  fi
}

#Install tools
function install::openapi()
{
  #Bash Launcher Script
  echo "log Info: Installing tools from bash at $to_workdir/$to_address"
  mkdir -p $to_workdir/${to_address}/openapitools
  echo "log info: downloading openapi JAR $version"
  if ! [ -f $to_workdir/$to_address/openapitools/openapi-generator-cli-$version.jar ]; then
    wget --no-check-certificate -qO- https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/$version/openapi-generator-cli-$version.jar > $to_workdir/$to_address/openapitools/openapi-generator-cli-$version.jar
    chmod a+x $to_workdir/$to_address/openapitools/openapi-generator-cli-$version.jar
    echo "log remove: $to_workdir/$to_address/openapitools/openapi-generator-cli.jar"
    echo "log info: downloading launcher"
    wget --no-check-certificate -qO- https://raw.githubusercontent.com/OpenAPITools/openapi-generator/master/bin/utils/openapi-generator-cli.sh > $to_workdir/$to_address/openapitools/openapi-generator-cli.sh
    echo "log remove: $to_workdir/$to_address/openapitools/openapi-generator-cli.sh"
    chmod u+x $to_workdir/$to_address/openapitools/openapi-generator-cli.sh
  fi
  JAVA_HOME=$(echo ${JAVA_HOME:-unset})
  if ! which java > /dev/null; then echo "log: Java not found...installing java jdk"; sudo apt install openjdk-11-jdk; echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bash_profile; fi
  if [[ $JAVA_HOME == 'unset' ]]; then echo "log: ERROR: Please set JAVA_HOME jdk java as export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 and relaunch script"; exit; fi
  if ! which mvn > /dev/null; then echo "log: I need install maven for deploy openapi."; sudo apt install maven; fi
  export PATH=$PATH:$to_workdir/$to_address/openapitools/
  # To "install" a specific version, set the variable in .bashrc/.bash_profile
  echo "export OPENAPI_GENERATOR_VERSION=$version" >> ~/.bash_profile
  echo "alias openapi-generator-cli=$to_workdir/$to_address/openapitools/openapi-generator-cli.sh" >> ~/.bash_profile
  echo "export PATH=$PATH:$to_workdir/$to_address/openapitools/" >> ~/.bash_profile
  export PATH=$PATH:$to_workdir/$to_address/openapitools/ >> ~/.bash_profile
  source ~/.bash_profile
  OPENAPI_GENERATOR_VERSION=$version
  echo "log info: Installed version -> $to_workdir/$to_address/openapitools/openapi-generator-cli.sh version" 
  version=$($to_workdir/$to_address/openapitools/openapi-generator-cli.sh version) # is always 3.0.2, unless any of the above overrides are done ad hoc
  summary::add "log summary: openapi-generator-cli version .....................................: ${version}"
  summary::add "log summary: Openapi Tools .....................................................: $to_workdir/$to_address/openapi-generator-cli.sh"
}


#Generator doc, server API and clients
function generator::ruby()
{
  #Ruby generator
  local from_address=$1
  local to_address=$2
  if [[ $to_workdir == 'unset' ]]; then echo "log Error: to generate you need options --to_workdir [path_tools]"; exit; fi
  if [[ $to_address == "unset" ]]; then echo "log Error: to generate you need options --to_address [out_path]"; exit; fi
  if [[ $from_address == "unset" ]]; then echo "log Error: to generate you need options --from_address [json|yaml]"; exit; fi
    
  if [ ! -d "${to_workdir}/${to_address}" ]; then 
    echo "log info: creating  out path ${to_workdir}/${to_address}"
    mkdir -p "${to_workdir}/${to_address}"
  fi
  echo "log info: command $to_workdir/openapi-generator-cli.sh generate -i ${from_address} -g ruby -o ${to_address}"
  $to_workdir/openapi-generator-cli.sh generate -i ${from_address} -g ruby-on-rails -o ${to_address}
}

#Genera python client,server API and doc TODO: CONNECT DATABASE
function generator::python3()
{
  #Ruby generator
  local from_address=$1
  local to_address=$2
  if [[ $from_address == "unset" ]]; then echo "log Error: Specification input file is empty --from_address [json|yaml]"; exit; fi
  if [ ! -s $from_address ]; then echo "log Error: Specification input file $from_address without schema, fil spec --from_address [json|yaml]"; exit; fi
  if [[ $tools_dir == 'unset' ]]; then echo "log Error: Path to open api tools is empty --tools_dir [path_opentapi_tools]"; exit; fi
  if [[ $to_workdir == 'unset' ]]; then echo "log Error: Path to root project is empty --to_workdir [path_root_project]"; exit; fi
  if [[ $to_address == "unset" ]]; then echo "log Error: Output path of generation is empty --to_address [out_path]"; exit; fi
  

  if [ ! -d "${to_workdir}/${to_address}" ]; then
    echo "log info: creating  out path ${to_workdir}/${to_address}"
    mkdir -p "${to_workdir}/${to_address}"
    summary::add "log summary: Out path ...........................................................: ${to_workdir}/${to_address}"
  fi
  
  template="${to_workdir}/doc/api/${api_version}/templates/htmlDocs"
  if [ ! -d "${template}" ]; then
    mkdir -p "$template"
    summary::add "log summary: Out Templates .....................................................: ${template}"
  fi

  #Valid specificacion JSON/YAML?
  validated=$($to_workdir/$tools_dir/openapi-generator-cli.sh validate -i ${from_address})   
  if [[ ${validated} =~ "No validation issues detected" ]]; then
    summary::add "log summary: Input specification file Json/Yaml ................................: ${from_address}"
    echo "log info: command $to_workdir/openapi-generator-cli.sh generate -i ${from_address} -g html -o ${to_address}"
    summary::add "log summary: Openapi Tools .....................................................: $to_workdir/$tools_dir/openapi-generator-cli.sh"
    $to_workdir/$tools_dir/openapi-generator-cli.sh generate -i ${from_address} -g markdown -o ${to_workdir}/doc/api/${api_version}/markdown
    $to_workdir/$tools_dir/openapi-generator-cli.sh generate -i ${from_address} -g html -o ${to_workdir}/doc/api/${api_version}/html -t $template
    summary::add "log summary: Openapi Documentation HTML and Markdown ...........................: ${to_workdir}/doc/api/${api_version}/"
    summary::add "log summary: Run doumentation server............................................: sudo python3 -m http.server --directory ${to_workdir}/doc/api/${api_version}/ 80" 
    $to_workdir/$tools_dir/openapi-generator-cli.sh generate -i ${from_address} -g mysql-schema -o $to_workdir/${to_address}/mysql-schema
    summary::add "log summary: Openapi mysql-schema ..............................................: $to_workdir/${to_address}/mysql-schema"
    $to_workdir/$tools_dir/openapi-generator-cli.sh generate -i ${from_address} -g python-fastapi -o ${to_address}/python-fastapi 
    summary::add "log summary: Out open api server document ......................................: cd $to_workdir/${to_address}"
    summary::add "log summary: Run API server (cution!! fastAPI is BETA)..........................: cd $to_workdir/${to_address}/python-fastapi/; python3 -m openapi_server"
    summary::add "log summary: url endpoint API server ...........................................: http://localhost:8080/api/${api_version}"
  else
    $to_workdir/$tools_dir/openapi-generator-cli.sh validate -i ${from_address}
    echo "ERROR JSON/YAML VALIDATION. solve and rerun. "
    exit 
  fi
}

#TOOD UI crud rules, now using swagger endpoint


#PROCESS
if [[ ${install} == 'install:openapi' ]]; then 
  install::openapi $to_address  $to_workdir 
fi

if [[ ${create_authority_json_yaml_metadata_specification} != unset ]]; then
  create::authority  $to_workdir $region $financial_authority $name_financial_instrument 
fi

if [[ ${generator} == 'generator::python3' ]]; then
  generator::python3 $from_address $to_address
fi

if [ "$_TEST" == 'on' ]; then

  function _test()
  {
   echo "TEST ${#0}"
  } 
  _test
  # call arguments verbatim:
  $@
fi
summary

