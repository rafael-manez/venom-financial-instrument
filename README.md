# venom-financial-instrument
 Venom for international regulated financial instruments -company shares, bonds, derivates, contracts...-


# Features:
  - Open Source Smart Contract - T-sol<-->Solididty compatibility only digital and decentralized compatibility -NOT centralized-
  - Manage Instruments: company shares, bonds, derivates, contracts
  - Third party audit: National Competent Authorities (NCa's) and Central Financial Authorities as ADGM Authorities, ESMA, NFRA, SEC, ...
  - Permissions for third parties (Access, Views, SeenByThird, operations, privacy level and indentities by nomial name or alias)
  - Validation transaction 
  - Security on transacction
  - Block and Unblock assets
  - Revocations
  - Asset history
  - Transform financial rules into programmable financial rules
  - Scriptable Functions (Interactive and non-Interactive)  
  
  
# Metadata tree and regulatory rules:
 
``` 
metadata/
└── companyShares
    ├── contract
    └── rules
        ├── CHINA
        ├── EU
        │   ├── ESMA
        │   └── NCA
        ├── INDIA
        │   └── NFRA
        ├── UAE
        │   └── ADGM
        └── USA
```

# Build on Isolated development Linux:
```
    Usage: ./UbuntuVenomBootable.sh DOWNLOAD_RELEASE ISO_FILE USB_BLOCK_DEVICE_NAME

    Brief: Cold system Venom. Create a isolated Bootable Persistent Live USB disk with Ubuntu, Venom, doker, venon requeriments and node in cold mode for       clean development and deploy in hub mode
    Requerimets: >100 GB USB DISK FOR COMPLETE NODE ENVIRONMENT
    Example: ./UbuntuVenomBootable.sh "ubuntu-20.04.6-live-server-amd64.iso" "/dev/sdc" "/media/${USER}/Ubuntu-Server 20.04.6 LTS amd64/
    1.$ chmod a+x UbuntuVenomBootable.sh
    2.$ DOWNLOAD_RELEASE=http://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso
    3.$ wget $DOWNLOAD_RELEASE
    4.$ ISO_FILE=ubuntu-20.04.6-live-server-amd64.iso
    5.$ USB_BLOCK_DEVICE_NAME=/dev/sdc
    6.$ MOUNTED_USB_DEVICE_AT="/media/${USER}/dir to mounte"... #Path where usb is mounted in your system for find  /media/.../boot/grub/grub.cfg to        persistence withow slash white
    6.$ ./UbuntuVenomBootable.sh "$ISO_FILE" "$USB_BLOCK_DEVICE_NAME" "$MOUNTED_USB_DEVICE_AT"
    7 From GRUB MENU push key "e" to edit persiten and change s/ quiet/persistent quiet/g  and press F10 to boot 
    7.bis Boot usb disk from bios
    8 Once Boot: Config Keyboard, network and default repository -ONLY CONFIG NOT INSTALL OR FORMAT-
    9 Jump shell console with tab from Help Menu
```
# Requeriments:
 - USB DISK > $(SIZE_NODE) VENOM

# Standards for development Use
 - ISO UNICODE, Countries, numbers, known lists
 - ACRONIMS FROM SOURCE
 - Alphabetical orders A-Z for lists and 0-9 numbers
 - File Name: [a.zA-Z0-9_-] example:  sharesCompany.json shares_company-shares.json company_shares.json
 - Write: UpperCamelCase for type aliases and struct, trait, enum, and enum variant names, SCREAMING_SNAKE_CASE for constants or statics and snake_case for variable, function and struct member names. 
 
# Human rights:
 Prevent the coldness of automatic execution of contracts on vulnerable population.
 
 
