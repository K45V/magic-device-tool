clear
echo ""
echo "Install Factory Image"
echo ""
echo "Please boot your Nexus 7 into fastboot mode by pressing Power & Volume Up (+)"
sleep 1
echo ""
echo -n "Is your Nexus 7 in fastboot mode now? [Y] "; read bootloadermode
if [ "$bootloadermode"==Y -o "$bootloadermode==y" -o "$bootloadermode"=="" ]; then
  clear
  echo ""
  echo "Detecting device"
  echo ""
  sleep 1
  fastboot devices > /tmp/AttachedDevices
fi
  if grep 'device$\|fastboot$' /tmp/AttachedDevices
  then
    echo "Device detected !"
    sleep 1
    clear
    echo ""
    echo "Downloading factory image.."
    echo ""
    wget -c --quiet --show-progress --tries=10 https://dl.google.com/dl/android/aosp/nakasi-lmy47v-factory-5a0bb059.zip
    sleep 1
    unzip nakasi*
    sleep 1
    fastboot oem unlock
    fastboot erase boot
    fastboot erase cache
    fastboot erase recovery
    fastboot erase system
    fastboot erase userdata
    fastboot flash bootloader ./nakasi-lmy47v/bootloader-grouper-4.23.img
    fastboot reboot-bootloader
    sleep 10
    fastboot -w update ./nakasi-lmy47v/image-nakasi-lmy47v.zip
    sleep 1
    echo ""
    echo "Move to your device to finish the setup."
    echo ""
    echo "Don't think your device is in a bootloop."
    echo "It can take up to 10 minutes until you see the Android Setup Screen"
    sleep 2
    echo ""
    echo "Cleaning up.."
    rm -f /tmp/AttachedDevices
    rm -rf ./nakasi-lmy47v
    #rm -f ./*.tgz
    echo ""
    sleep 1
    echo "Exiting script. Bye Bye"
    sleep 1
    exit
  else
    echo "Device not found"
    rm -f /tmp/AttachedDevices
    exit
  fi
