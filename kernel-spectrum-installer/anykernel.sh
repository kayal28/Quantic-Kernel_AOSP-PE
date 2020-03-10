# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Quantic Kernel by Ayrton990@XDA
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=cepheus
device.name2=cepheus-user
device.name3=Mi 9
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;


## AnyKernel install
dump_boot;

# begin ramdisk changes
if [ -d $ramdisk/.backup ]; then
  ui_print " "; ui_print "Patching ramdisk...";
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;

# Clean up other kernels' ramdisk overlay.d files
rm -rf $ramdisk/overlay.d
# Add our ramdisk files if Magisk is installed
if [ -d $ramdisk/.backup ]; then
	ui_print " "; ui_print "Installing Spectrum"
	mv /tmp/anykernel/overlay.d $ramdisk/overlay.d
	cp -f /system_root/init.rc $ramdisk/overlay.d
	sleep 2
		insert_line $ramdisk/overlay.d/init.rc "init.spectrum.rc" after 'import /init.usb.rc' "import /init.spectrum.rc"
		ui_print "-> Spectrum installed succesfully"
    set_perm_recursive 0 0 750 750 $ramdisk/*
fi;
	

#Thanks to pappschlumpf for the ramdisk detection method :D

# end ramdisk changes
write_boot;
## end install

ui_print "-> Please reinstall Magisk_20.3"
ui_print " ";
ui_print " ";
ui_print "Quantic has been succesfully installed!";
ui_print "If you have any bug please report to";
ui_print "@Ayrton990 on telegram";
ui_print " ";
ui_print "Follow @ayrton990mods on Telegram ";
ui_print " ";
ui_print " ";
