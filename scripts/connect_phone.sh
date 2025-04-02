#!/usr/bin/bash
adb tcpip 5555
adb connect 192.168.2.202:5555
scrcpy &
