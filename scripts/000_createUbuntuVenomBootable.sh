#!/bin/bash

#Create Bootable USB Disk Ubuntu Venom requeriments and node in cold mode for development and deploy in hub mode.
#Full system not Disk /dev/loop* for loop boot see https://help.ubuntu.com/community/Grub2/ISOBoot
#by Cobbhub.com team.

clear
echo ""
echo "************************** CREATE A PERSISTENT LIVE USB ENVIRONMENT FOR SMART CONTRAT DEVELOPMENT ON FINANCIAL INSTRUMENTS *****************************"
echo ""

function usage(){
  echo '' 
  echo 'Usage: ./000_createUbuntuVenomBootable.sh DOWNLOAD_RELEASE ISO_FILE USB_BLOCK_DEVICE_NAME'
  echo 'Brief: Cold system Venom. Create a Isolated Bootable Persistent Live USB disk with Ubuntu Server, Venom requeriments and node in cold mode for clean development and deploy in hub mode'
  echo 'Requerimets: >100 GB USB DISK FORMATED or EMPTY'
  echo 'Security level: High. Could be break your system. Each run removes all the latest content to update to the new system requirements. Please READ LINE BY LINE THIS SCRIPT'
  echo 'ISO recomended: http://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso'
  echo 'Example: ./000_createUbuntuVenomBootable.sh "ubuntu-20.04.6-live-server-amd64.iso" "/dev/sdc" "/media/${USER}/Ubuntu-Server 20.04.6 LTS amd64/'
  echo '1.$ chmod a+x 000_createUbuntuVenomBootable.sh'
  echo '2.$ DOWNLOAD_RELEASE=http://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso'
  echo '3.$ wget $DOWNLOAD_RELEASE'
  echo '4.$ ISO_FILE=ubuntu-20.04.6-live-server-amd64.iso'
  echo '5.$ USB_BLOCK_DEVICE_NAME=/dev/sdc   #sudo fdisk -l  to find your device'
  echo '6.$ MOUNTED_USB_DEVICE_AT="/media/${USER}/dir to mounted" ... #Path where usb is mounted in your system for find  /media/.../boot/grub/grub.cfg without slash white'
  echo '7.$ ISO_LABEL="Ubuntu-Server-cusomized-amd64"' 
  echo '8.$ ./UbuntuVenomBootable.sh "$ISO_FILE" "$USB_BLOCK_DEVICE_NAME" "$MOUNTED_USB_DEVICE_AT"' #double quotes for path with white space whitouth slash white '\ '
  echo '9 Boot usb disk from bios'
  echo '10 Once Boot: Config Keyboard, network and default repository -ONLY CONFIG NOT INSTALL OR FORMAT-'
  echo '11 Jump shell console with tab from Help Menu and run venon-financial-instruments from bash scripts.'
  echo '12 end ;)'
  echo ''
}

#Set Vars 
ISO_FILE="${1}"
USB_BLOCK_DEVICE_NAME="${2}"
MOUNTED_USB_DEVICE_AT="${3}"
DEFAULT_ISO_LABEL="ubuntu-persistent-$(date '+%Y%m%d%H%M%S')"
ISO_LABEL=${4:-${DEFAULT_ISO_LABEL}} #like 'Ubuntu-Server-cusomized-amd64'
echo "Executing...# ./UbuntuVenomBootable.sh \"$ISO_FILE\" \"$USB_BLOCK_DEVICE_NAME\" \"${MOUNTED_USB_DEVICE_AT}\" \"${ISO_LABEL}\""
if [ -z "${ISO_FILE}" ] || [ -z "${USB_BLOCK_DEVICE_NAME}" ] || [ -z "${MOUNTED_USB_DEVICE_AT}" ]; then
  usage;
  exit 0
fi

#Local packages requeriments
echo "I need install some package in your local"
sudo apt install wget #for download urls
sudo apt install gddrescue #for burn usb iso
sudo apt install mkisofs #for modify iso files
sudo apt install xorriso #pack iso files
sudo apt install syslinux-utils #for isohiybrid, make bootable uefi
sudo apt install mtools

#ISO Download Final Release (stable) and check file
if ! [ -f ${ISO_FILE} ]; then 
  echo ""
  echo "Error.................................."
  echo "File $ISO_FILE not exist. Check path or"
  echo "Downlaod with wget url"
  echo "---------------------------------------"
  echo ""
  usage
  exit 1
fi

#Is usb present?
EXIST_USB_BLOCK_DEVICE=$(sudo fdisk -l | grep -Eo "Disk\s*$USB_BLOCK_DEVICE_NAME" | grep -o $USB_BLOCK_DEVICE_NAME)
if ! [[ "${EXIST_USB_BLOCK_DEVICE}" == "${USB_BLOCK_DEVICE_NAME}" ]]; then 
  echo ""
  echo "Error........................................................."
  echo "Usb block ${USB_BLOCK_DEVICE_NAME}. Not found check next list."
  echo ".............................................................."
  sudo fdisk -l | grep "Disk /.*"
  echo ""
  usage
  exit 1
fi

#Edit ISO file, add files and config
echo "Edit ISO file, add files and config"
origin_iso="/mnt/origin_iso"
modified_iso="/mnt/modified_iso"
out_modified_iso="/tmp/modified_$ISO_FILE"
sudo mkdir "$origin_iso"
sudo mkdir "$modified_iso"
sudo mount -o ro,loop $ISO_FILE $origin_iso #loop is stimated free. if not free set another loop*
#Additionally to the MBR for legacy BIOS CD AND USB
MBR_FILE=/tmp/ubuntu_isohybrid_mbr.img
dd if="$ISO_FILE" bs=1 count=432 of="$MBR_FILE"
sudo cp -r $origin_iso/* $modified_iso
sudo umount $origin_iso
sudo cp $ISO_FILE $modified_iso
cd $modified_iso


#add files and configs HERE!
##start config
echo "Set live USB to persitent Live USB"
GRUB_CONFIG_FILE="$(find "$modified_iso" -iname 'grub.cfg' | grep '.*boot/grub/grub.cfg')"
echo "Reconfing $GRUB_CONFIG_FILE..."
ls -l "$(echo "${GRUB_CONFIG_FILE}")"
###reconfig_grub="sed 's/ quiet/persistent quiet/g' '"$(echo "${GRUB_CONFIG_FILE}")"'" 
###echo "${reconfig_grub}"
####sudo sed -i 's/ quiet/persistent quiet/g' "$(echo "${GRUB_CONFIG_FILE}")"
sudo tee -a "$(echo "${GRUB_CONFIG_FILE}")" <<EOF
menuentry "Try Ubuntu Server Persintent" {
	set gfxpayload=keep
	linux	/casper/vmlinuz persistent ---
	initrd	/casper/initrd
}
EOF
echo "Set new checksum list files....."
sudo rm -f $modified_iso/md5sum.txt
find . -type f -not -name md5sum.txt -print0 | xargs -0 md5sum | sudo tee md5sum.txt #set new check sum files
##end config


#Create new ISO 
echo "Reports original ISO and config for clone customized package..."
xorriso -report_about warning -indev "$ISO_FILE" -report_system_area as_mkisofs
report_ISO_TO_CUSTOMIZED=$(xorriso -report_about warning -indev "$ISO_FILE" -report_system_area as_mkisofs)
report_ISO_TO_CUSTOMIZED=$(echo "$report_ISO_TO_CUSTOMIZED" | sed -E -e "s/-V(\s+)?.*'$/-V '$ISO_LABEL'/g")  #set name volid
report_ISO_TO_CUSTOMIZED=$(echo "$report_ISO_TO_CUSTOMIZED" | sed -E 's/--modification-date=(\s+)?.*$/ --modification-date="'$(date '+%Y%m%d%H%M%S00')'" /g') #Package date
report_ISO_TO_CUSTOMIZED=$'\n'"$report_ISO_TO_CUSTOMIZED"$'\n'"-o '$out_modified_iso'"  #Add output file
report_ISO_TO_CUSTOMIZED="$report_ISO_TO_CUSTOMIZED"$'\n'"$modified_iso" #Add out dir

echo "Packing customized ISO..............."
pack_customized='sudo xorriso -indev "'${ISO_FILE}'" -as mkisofs -r '$report_ISO_TO_CUSTOMIZED
pack_customized=$(echo "$pack_customized" | tr "\n" " ")
#$($pack_customized) #string function problems with trailings in some bash 
#exect tmp script 
sudo touch "/tmp/pack_0_0_1.sh"
sudo echo '#!/bin/bash' | sudo tee -a /tmp/pack_0_0_1.sh
sudo echo "$pack_customized" | sudo tee -a /tmp/pack_0_0_1.sh
sudo chmod a+x /tmp/pack_0_0_1.sh
/tmp/./pack_0_0_1.sh
sudo rm /tmp/pack_0_0_1.sh

#example for ubuntu-20.04.6-live-server-amd64.iso
#sudo xorriso -indev "${ISO_FILE}" -as mkisofs -r \
#  -V $ISO_LABEL \
#  -o "$out_modified_iso" \
#  --modification-date="$(date '+%Y%m%d%H%M%S00')"  \
#  -isohybrid-mbr --interval:local_fs:0s-15s:zero_mbrpt,zero_gpt,zero_apm:"${ISO_FILE}" \
#  -partition_cyl_align on \
#  -partition_offset 0 \
#  -partition_hd_cyl 89 \
#  -partition_sec_hd 32 \
#  --mbr-force-bootable \
#  -apm-block-size 2048 \
#  -iso_mbr_part_type 0x00 \
#  -c '/isolinux/boot.cat' \
#  -b '/isolinux/isolinux.bin' \
#  -no-emul-boot \
#  -boot-load-size 4 \
#  -boot-info-table \
#  -eltorito-alt-boot \
#  -e '/boot/grub/efi.img' \
#  -no-emul-boot \
#  -boot-load-size 8128 \
#  -isohybrid-gpt-basdat \
#  -isohybrid-apm-hfsplus \
#  "$modified_iso"

if [[ $? -ne 0 ]]; then
  echo ""
  echo "Error........................................................."
  echo "Failed Packagin bootable. See, some parameter is bad"
  echo ".............................................................."
  echo ""
  usage
  exit 1
else
  sync
  sleep 5
  ls -l $out_modified_iso
  #sudo isohybrid --uefi $out_modified_iso
  sudo rm -r $modified_iso
  sudo rm -r $origin_iso
  cd -
  echo "Iso created at $(ls -d $out_modified_iso)"
fi


#create bootable usb
echo "Creating USB PERSISTENT live....................................."
echo "create ddrescue ${out_modified_iso} ${USB_BLOCK_DEVICE_NAME} --force -D"
sudo ddrescue ${out_modified_iso} ${USB_BLOCK_DEVICE_NAME} --force -D
if [[ $? -ne 0 ]]; then 
  echo ""
  echo "Error........................................................."
  echo "Failed creation bootable. See,if USB is mounted or accesible"
  echo ".............................................................."
  echo ""
  usage
  exit 1
fi

#sudo rm $out_modified_iso
sync
echo "END OF PROCESS. Boot new iso at new computer place and execut script for booted System"

exit

