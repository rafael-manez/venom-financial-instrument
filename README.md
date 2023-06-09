# venom-financial-instruments
 Venom for international regulated financial instruments -company shares, bonds, derivates, contracts...-

 - Read VEP (Venom Enhance Proposals) file [VEP.md](VEP.md)

# Features:
  - Open Source Smart Contract - T-sol <--> Solididty compatibility only digital and decentralized compatibility -NOT centralized-
  - Manage Instruments: company shares, bonds, derivates, contracts
  - Third party audit: National Competent Authorities (NCa's) and Central Financial Authorities as ADGM Authorities, ESMA, NFRA, SEC, ...
  - Permissions for third parties (Access, Views, SeenByThird, operations, privacy level and indentities by nomial name or alias)
  - Jurisdictional limits
  - Validation transaction 
  - Security on transacction
  - Block and Unblock assets
  - Revocations and recoveries
  - Asset history
  - Transform financial rules into programmable financial rules
  - Scriptable Functions (Interactive and non-Interactive) for manage by AI
  
  
# Metadata tree, regulatory rules and specifications:
 
```
  metadata
  |-- api
  |   `-- v1
  |       `-- mysql-schema
  |           |-- Model
  |           |   |-- Error.sql
  |           |   |-- NewRule.sql
  |           |   |-- Rule.sql
  |           |   `-- RuleAllOf.sql
  |           |-- README.md
  |           `-- mysql_schema.sql
  `-- specificacion
      `-- v1
          |-- ALL
          |   `-- Authorities
          |       `-- rulesBook.yaml
          `-- EU
              `-- ESMA
                  `-- companyShares.yaml

```

# Run on Isolated development Linux:
```
 Usage: ./000_createUbuntuVenomBootable.sh DOWNLOAD_RELEASE ISO_FILE USB_BLOCK_DEVICE_NAME
 
 Brief: Cold hardware system Venom. Create a Isolated Bootable Persistent Live USB disk with Ubuntu Server, Venom requeriments and node in cold mode for clean development and deploy in hub mode.
 
 Requerimets: >100 GB USB DISK FORMATED or EMPTY
 
 Security level: High. Could be break your system. Each run removes all the latest content to update to the new system requirements. Please READ LINE BY LINE THIS SCRIPT
 
 ISO recomended: http://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso
 ISO recomended: http://releases.ubuntu.com/22.10/ubuntu-22.10-live-server-amd64.iso
 
 Ussage: ./000_createUbuntuVenomBootable.sh "$ISO_FILE" "$USB_BLOCK_DEVICE_NAME" "$MOUNTED_USB_DEVICE_AT"
 1.$ chmod a+x 000_createUbuntuVenomBootable.sh
 2.$ DOWNLOAD_RELEASE=http://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso
 3.$ wget $DOWNLOAD_RELEASE
 4.$ ISO_FILE=ubuntu-20.04.6-live-server-amd64.iso
 5.$ USB_BLOCK_DEVICE_NAME=/dev/sdc   #sudo fdisk -l  to find your device
 6.$ MOUNTED_USB_DEVICE_AT="/media/${USER}/dir to mounted" ... #Path where usb is mounted in your system for find  /media/.../boot/grub/grub.cfg without slash white
 7.$ ISO_LABEL="Ubuntu-Server-cusomized-amd64"
 8.$ ./UbuntuVenomBootable.sh "$ISO_FILE" "$USB_BLOCK_DEVICE_NAME" "$MOUNTED_USB_DEVICE_AT"
 9 Boot usb disk from bios
 10 Once Boot: Config Keyboard, network and default repository -ONLY CONFIG NOT INSTALL OR FORMAT-
 11 Jump shell console with tab from Help Menu and run venon-financial-instruments from bash scripts.
 12 end ;)
 
 Example: 
  ./000_createUbuntuVenomBootable.sh "ubuntu-20.04.6-live-server-amd64.iso" "/dev/sdc" "/media/${USER}/Ubuntu-Server 20.04.6 LTS amd64/

```
# Create Instruments
```
  Usage: ./001_config_venom_environment.sh "$WORK_SPACE" "PROJECT_NAME_INSTRUMENT"
  Brief: install and config doker, node, yarn, npm, locklift and wokspace at default $WORK_SPACE/$PROJECT_NAME
   1.# chmod a+x 001_config_venom_environment.sh
   2.# WORK_SPACE="/mnt/usb/venon/venom-financial-instruments' #work space should have the word venom-financial-instruments
   3.# PROJECT_NAME_INSTRUMENT="companyShares"
   4.# ./001_config_venom_environment.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT"

```
# Test Instruments
```
  Usage: ./002_test_venom_instrument.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT" "[$CONTEXT_ENVIRONMENT]"
  Brief: Test instrument by locklift at defaul wokspace /venom-financial-instruments with config file for dev at .env and default context to launch docker/local-hode of [local|testnet|mainnet]
   1.# chmod a+x 002_test_venom_instrument.sh
   2.# eval $(ssh-agent -s); ssh-add ~/.ssh/venom_rsa; ssh -T git@github.com	#Active git agent to interact with live user
   3.# WORK_SPACE="/mnt/usb/venon/venom-financial-instruments	#work space should have the word venom-financial-instruments
   4.# PROJECT_NAME_INSTRUMENT="companyShares"
   5.# CONFIG_FILE_ENVIRONMENT=".env"	#If not exists create with "·ouch .nv"
   6.# CONTEXT_ENVIRONMENT="local"	#Optional Context to launch [local | testnet | mainnet]  Default local launch docker/local-node
   7.# ./002_test_venom_instrument.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT" "$CONFIG_FILE_ENVIRONMENT"

  Example:
    WORK_SPACE="/home/venom/venom-financial-instruments/"; 
    PROJECT_NAME_INSTRUMENT="companyShares"; 
    CONFIG_FILE_ENVIRONMENT=".env"; 
    CONTEXT_ENVIRONMENT="local"; 
    ./scripts/002_test_venom_instrument.sh "$WORK_SPACE" "$PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT" "$CONTEXT_ENVIRONMENT"
```
# Create financial rules
```
  brief:  Create financial rules specification for authorities, region and main financial rules book, install open api, create cli/server/web3connet to auto code
  usage: ./003_createFinancialRules.sh [--install install:openap] [--to_workdir] [--create_authority_json_yaml_metadata_specification]
   1.- Install from bash .............................................................................................
  	./003_createFinancialRules.sh --install install:openapi --to_workdir ~/venom-financial_instruments/ --version 6.6.0 --to_address /bin
  
   2.- Create a main rules book specification [JSON|YAML] for all financial and compatible regions ...................
  	WORK_SPACE=~/venom-financial-instruments/metdata/specification/v1
        REGION="ALL" #[ALL,EU,EU/LU,EU/FR,UAE,UAE/AZ,US/NY]
        FINANCIAL_AUTHORITY="Authorities" #[Authorities,ESMA,SEC,ESCA,CNA_SP,CNA_NY]
        FINANCIAL_INSTRUMENT="rulesBook.yaml"
	./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification  --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"

   3.- Create a iso region authority for instruments from DLT MI tool.................................................
	WORK_SPACE=~/venom-financial-instruments/metadata/specification/v1
        REGION="EU" #[EU,EU/LU,EU/FR,UAE,UAE/AZ,US/NY]
        FINANCIAL_AUTHORITY="ESMA" #[ESMA,SEC,ESCA,CNA_SP,CNA_NY]
        FINANCIAL_INSTRUMENT="companyShares.yaml"  #[companyShares.yaml, bonds.yaml, derivates.yaml...]
	./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"

   4.- Generate openapi Client models, Server API, markdown and html documents .......................................
 	WORK_SPACE=~/venom-financial-instruments/
 	TOOLS_DIR=/bin/openapitools
	FROM_ADDRESS=~/venom-financial-instruments/metadata/specification/v1/EU/ESMA/companyShares.yaml
 	TO_ADDRESS=/metadata/api/EU/ESMA/
	./003_createFinancialRules.sh --generator generator::python3 --to_workdir "$WORK_SPACE" --tools_dir "$TOOLS_DIR" --from_address "$FROM_ADDRESS" --to_address "$TO_ADDRESS"

   5.- Run servers.
       server API.: cd $WORK_SPACE/$TO_ADDRESS/python/; python3 -m openapi_server
       api endpoint: http://localhost:8080/api/v1
       server doc.: sudo python3 -m http.server --directory $WORK_SPACEi/doc/api/v1/ 80
       doc out....: http://localhost:8080/doc/api/v1

   Test ............................................................................. ./003_createFinancialRules.sh --test
   Remote usage ..................................................................... ssh user@192.168.3.113 echo password | sudo -Sv && bash -s sudo < ./003_createFinancialRules.sh --generate ...


   Examples.......................................................................................................
     Install Open Api and tools
 	./003_createFinancialRules.sh --install install:openapi --to_workdir ~/venom-financial_instruments --version 6.6.0 --to_address /bin
     Create rulebook.yaml specification for all authorities
       WORK_SPACE=~/venom-financial-instruments/metadata/specificacion/v1; REGION="ALL"; FINANCIAL_AUTHORITY="Authorities"; FINANCIAL_INSTRUMENT="rulesBook.yaml";
       ./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"
     Create competent authorities
       WORK_SPACE=~/venom-financial-instruments/; TOOLS_DIR="/bin/openapitools"; FROM_ADDRESS=~/venom-financial-instruments/metadata/specificacion/v1/EU/ESMA/companyShares.yaml; FINANCIAL_INSTRUMENT="companyShares.yaml";
       ./003_createFinancialRules.sh --create_authority_json_yaml_metadata_specification --to_workdir "$WORK_SPACE" --region "$REGION" --financial_authority "$FINANCIAL_AUTHORITY" --name_financial_instrument "$FINANCIAL_INSTRUMENT"
     Create Server and Client stubs from financial instrument specification
        WORK_SPACE=~/venom-financial-instruments/; TOOLS_DIR="/bin/openapitools"; FROM_ADDRESS=~/venom-financial-instruments/metadata/specificacion/v1/EU/ESMA/companyShares.yaml; TO_ADDRESS="/metadata/api/EU/ESMA";
        ./003_createFinancialRules.sh --generator generator::python3 --to_workdir "$WORK_SPACE" --tools_dir "$TOOLS_DIR" --from_address "$FROM_ADDRESS" --to_address "$TO_ADDRESS"
     Run SERVERS
       cd $WORK_SPACE/$TO_ADDRESS/python/; python3 -m openapi_server #http://localhost:8080/api/v1
       sudo python3 -m http.server --directory $WORK_SPACEi/doc/api/v1/ 80 #http://localhost:8080/doc/api/v1

```

# Pre format rules to burn contracts
```
  usage: ./004_financialRulesToGas.sh  "$financial_instrument" "$fromJurisdiction"[,"fromJurisdiction1,..."], ["$toJurisdiction"] "$interfacePreParameter"

  #Intervinients financialInstrument, fromJurisdiction, toJurisdiction -> metadata
  #Load metadata rules for financial instruments between intervinients -> binary
  #sendPreParameter binary to [Web3, HeadLess, RPC] -> burn contract
  #Result of action.
```

# Summary stable versions:
```
 node -v ..................: v19.9.0
 yarn -v ..................: 1.22.19
 npm -v  ..................: 9.6.3 
 docker --version .........: Docker version 23.0.4, build f480fb1
 cmake --version ..........: cmake version 3.24.2  CMake suite maintained and supported by Kitware (kitware.com/cmake). 
 config file .env..........: /home/venom/venom-financial-instruments//companyShares/.env
 TON-Solidity-Compiler.....: solc, the solidity compiler commandline interface Version: 0.68.0+commit.0585d525.mod.Linux.g++ 
 tvm_linker -V.............: v0.20.2
 docker tonlabs/local-node.: tonlabs/local-node:0.29.1
 cargo --version...........: cargo 1.65.0
 locklift --version........: 2.5.5
 PATH TO PROJECT...........: cd /home/venom/venom-financial-instruments//companyShares
 Tree project..............: tree --gitignore /home/venom/venom-financial-instruments//companyShares
```

# Requeriments:
 - USB DISK > $(SIZE_NODE) VENOM

# Standards for development Use
 - ISO UNICODE, Countries, numbers, known lists
 - ACRONIMS FROM SOURCE
 - Alphabetical orders A-Z for lists and 0-9 numbers
 - File Name: [a-zA-Z0-9_-] example:  sharesCompany.json shares_company-shares.json company_shares.json
 - Write: UpperCamelCase for type aliases and struct, trait, enum, and enum variant names, SCREAMING_SNAKE_CASE for constants or statics and snake_case for variable, function and struct member names. 
 - JSON files as metadata container 
 - Bash script files as scripting standard constructors: 000_script_name.sh ... 00N_script_name.sh
 
# Human rights:
 Prevent the coldness of automatic execution of contracts on vulnerable population.
 
# Contribute
 Contributions are always welcome!


# Last auto-generated tree:
```
.
|-- ERROR_SANATION.md
|-- LICENSE
|-- README.md
|-- VEP.md
|-- bin
|   `-- openapitools
|       |-- openapi-generator-cli-6.6.0.jar
|       `-- openapi-generator-cli.sh
|-- companyShares
|   |-- build
|   |   |-- Sample.abi.json
|   |   |-- Sample.base64
|   |   |-- Sample.code
|   |   |-- Sample.tvc
|   |   `-- factorySource.ts
|   |-- contracts
|   |   `-- Sample.tsol
|   |-- locklift.config.ts
|   |-- package-lock.json
|   |-- package.json
|   |-- scripts
|   |   `-- 1-deploy-sample.ts
|   |-- test
|   |   `-- sample-test.ts
|   `-- tsconfig.json
|-- doc
|   `-- api
|       `-- v1
|           |-- html
|           |   `-- index.html
|           |-- markdown
|           |   |-- Apis
|           |   |   |-- RULEApi.md
|           |   |   `-- RuleBookApi.md
|           |   |-- Models
|           |   |   |-- Error.md
|           |   |   |-- NewRule.md
|           |   |   |-- Rule.md
|           |   |   `-- Rule_allOf.md
|           |   `-- README.md
|           `-- templates
|               `-- htmlDocs
|-- metadata
|   |-- api
|   |   `-- v1
|   |       `-- mysql-schema
|   |           |-- Model
|   |           |   |-- Error.sql
|   |           |   |-- NewRule.sql
|   |           |   |-- Rule.sql
|   |           |   `-- RuleAllOf.sql
|   |           |-- README.md
|   |           `-- mysql_schema.sql
|   `-- specificacion
|       `-- v1
|           |-- ALL
|           |   `-- Authorities
|           |       `-- rulesBook.yaml
|           `-- EU
|               `-- ESMA
|                   `-- companyShares.yaml
`-- scripts
    |-- 000_createUbuntuVenomBootable.sh
    |-- 001_config_venom_environment.sh
    |-- 002_test_venom_instrument.sh
    `-- 003_createFinancialRules.sh

```
