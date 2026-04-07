#!/system/bin/sh
MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 5
done

(
    PKG="io.github.x0eg0.magisk"
    cooldown=0

     logcat -v brief -e "Failed to stat.*io.github.huskydg.magisk" | while read -r line; do
        
        if [ "$cooldown" -eq 1 ]; then continue; fi
        cooldown=1

        am force-stop $PKG
        sleep 1

        am broadcast -a android.intent.action.BOOT_COMPLETED -p $PKG -f 32 > /dev/null 2>&1

        ( sleep 5; cooldown=0 ) &
    done 
) &
