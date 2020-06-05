# Project Nemo : A custom AOSP 9.0 Emulator Device Configuration


## Device configuration (nemo)

Basic   | Spec Sheet
-------:|:----------
CPU     | Generic x86 arch
Chipset | Generic
GPU     | Generic
ROM     | 8GB
RAM     | xGB
Android | 9.0
Battery | 1505 mAh
Display | 1920x1080 pixels, 420PPI

## FEATURES
1.  <del>Adding Google Apps Suite.</del>
2.  Adding bootanimation file.
3.  Overlaying the framework and SystemUI:
    1.  Customizing the Default wallpaper.
    2.  Turn SCreen ON/OFF on cable attached/detached.
    3.  Enable Auto Brightness Mode.
    4.  Enable MultiUser Mode.
    5.  Change the battery Warning Levels.
    6.  The default suggested battery % at which we enable battery saver automatically.
    7.  Configure DOZE Mode.
    8.  Configure Google Assisstant App Component.
    9.  Configure the ICONs mask for the system (set it to ROUND).
    10. Enable Swipe Up gesture and Set it True by default (Android new navbar gestures).
    11. Enable Night Mode.
    12. Enable Sustained Performance Mode.
    13. Configure Round Corner Radius on SystemUI.
    14. Set the Default Screen Brightness Level to 100%.
    15. Enable WiFi by default.
    16. Enable LockScreen by default.
    17. The default tiles to display in QuickSettings.
    18. Should "LTE" be shown instead of "4G" when the network is NETWORK_TYPE_LTE
5.  Integrate Google Wellbeing App (check the document prebuilt/common/apps/Wellbeing/README).
6.  Add dark theme to Google Dialer App (check the Patch down below).
7.  Create a Service "userinit" and attach it to a trigger event ( init.ranchu.rc ) to:
    - Enable Flip to Ssshhh.
    - Grant Google Apps Location permissions.

            on property:sys.boot_completed=1
                start userinit
            service userinit /system/bin/userinit.sh
            class core
            user root
            group root system
            disabled
            oneshot

8.  Add a cutom versionning makefile to set a custom: fingerprint, version, build date.
9.  Enable the OEM Unlock Bootloader Support.
10. Add Battery level animation on Setttings.
11. Enable Status Bar overlay on drak theme change

## PATCHES

1.  Patch added : AOSP_PIE_9.0/frameworks/base/packages/SystemUI/src/com/android/systemui/statusbar/phone/StatusBar.java

    Source: https://gerrit.pixelexperience.org/c/frameworks_base/+/230/3/packages/SystemUI/src/com/android/systemui/statusbar/phone/StatusBar.java#4179 (enable overlay for dark mode)


## ISSUES & BUGS

1.  the overlay under the folder "packages" is not working and not applied -> potentiel fix; the density resolution and AAPT
2.  init.userinit.sh : works on selinux permissive mode But not enfrocing mode. Issue related to : SELinux
    Solution Update and how to fix it:

    - Create a policy file (userinit.te)

            ###########  userinit service
                type userinit, domain, coredomain;
                type userinit_exec, exec_type, file_type;
                init_daemon_domain(userinit)
            ###########

    - Label the Script file ( add the follwing to sepolicy/file_contexts):

            ###########
                /system/bin/userinit.sh  u:object_r:userinit_exec:s0
            ###########

        Source: https://source.android.com/security/selinux/device-policy

    - Use Audit2allow tool to diagnose the denials and convert them to the corresponding SELinux policy statments:

            ###########
                adb pull /sys/fs/selinux/policy
                adb logcat -b all -d | audit2allow -p policy
            ###########

    - Output:

            ###########
            #============= userinit ==============
            allow userinit shell_exec:file { open read };
            ###########

    - Add the statement to the script policy file (userinit.te) :

            ###########
            type userinit, domain, coredomain;
            type userinit_exec, exec_type, file_type;
            init_daemon_domain(userinit)
            allow userinit shell_exec:file { open read };
            ###########



## Maintainers
This project is mantained by:
* [Abdelkader SELLAMI](https://github.com/islem19)


## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push your branch (git push origin my-new-feature)
5. Create a new Pull Request


## License
This application is released under GNU GPLv3 (see [LICENSE]()). Some of the used libraries are released under different licenses.
