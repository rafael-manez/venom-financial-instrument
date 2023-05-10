# venom-financial-instruments
 Venom for international regulated financial instruments -company shares, bonds, derivates, contracts...-


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
  - Scriptable Functions (Interactive and non-Interactive)  
  
  
# Metadata tree, regulatory rules and builder:
 
```
 .
 |-- LICENSE
 |-- README.md
 |-- VEP
 |-- metadata
 |   `-- companyShares
 |       |-- contract
 |       `-- rules
 |           |-- CHINA
 |           |-- EU
 |           |   |-- ESMA
 |           |   `-- NCA
 |           |-- INDIA
 |           |   `-- NFRA
 |           |-- UAE
 |           |   `-- ADGM
 |           `-- USA
 |               `-- SEC
 `-- scripts
     `-- 000_createUbuntuVenomBootable.sh
     `-- 001_config_venom_environment.sh
 
```

# Run on Isolated development Linux:
```
 Usage: ./000_createUbuntuVenomBootable.sh DOWNLOAD_RELEASE ISO_FILE USB_BLOCK_DEVICE_NAME
 
 Brief: Cold system Venom. Create a Isolated Bootable Persistent Live USB disk with Ubuntu Server, Venom requeriments and node in cold mode for clean development and deploy in hub mode
 
 Requerimets: >100 GB USB DISK FORMATED or EMPTY
 
 Security level: High. Could be break your system. Each run removes all the latest content to update to the new system requirements. Please READ LINE BY LINE THIS SCRIPT
 
 ISO recomended: http://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso
 ISO recomended: http://releases.ubuntu.com/22.10/ubuntu-22.10-live-server-amd64.iso
 
 Example: ./000_createUbuntuVenomBootable.sh "ubuntu-20.04.6-live-server-amd64.iso" "/dev/sdc" "/media/${USER}/Ubuntu-Server 20.04.6 LTS amd64/
 
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
  Usage: ./002_test_venom_instrument.sh "$WORK_SPACE" "PROJECT_NAME_INSTRUMENT" "$CONFIG_FILE_ENVIRONMENT"
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

