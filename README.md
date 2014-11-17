uiautomator
===========

a docker image for uiautomator  ( python adb uiautomator on debian:wheezy)


composition
========
debian:wheezy
	cocoon/base ( python (ansible ready))
		cocoon/uiautomator ( adb + python uiautomator wrapper )



usage
=====

start the container

```
sudo docker run --privileged -v /dev/bus/usb:/dev/bus/usb -ti --rm -P  cocoon/uiautomator /bin/bash
```



use it

```
# adb devices
* daemon not running. starting it now on port 5037 *
* daemon started successfully *
List of devices attached
e7f54be6	offline
388897e5	offline

# python

>>> from uiautomator import Device
>>> d = Device('e7f54be6')
>>> d.info
{u'displayRotation': 0, u'displaySizeDpY': 640, u'displaySizeDpX': 360, u'displayWidth': 1080, u'productName': u'kltexx', u'currentPackageName': u'com.sec.android.app.launcher', u'sdkInt': 19, u'displayHeight': 1920, u'naturalOrientation': True}
>>> d.press('home')
True
>>>



```