# linux-surface-overlay
Gentoo Overlay with surface kernel and other utilities from the linux-surface repo. If you find any issues feel free to help resolve them or report them at least.

# Installing Gentoo
For installing Gentoo on a Surface device you can follow the [Gentoo Handbook](https://wiki.gentoo.org/wiki/Handbook:AMD64).
For better hardware support you will need to use the ```surface-sources``` package from this repo instead of the regular ```gentoo-sources```. Make sure to enable the appropriate kernel options. For some hardware (namely the touchscreen) you'll need to install the additional packages in this repo.

# Usage
Use layman or eselect repositiory.

```# layman -a linux-surface```

```# eselect repository enable linux-surface```


# Packages
- surface-sources (the normal gentoo-sources with surface patchsets applied)
- iptsd (deamon for touchscreen support; enable the service after installing)
- libwacom-surface (for better touchscreen support)
- surface-control (a commandline utility for controlling various aspects of surface devices)

## Notices
### surface-dtx-daemon
Surface-dtx-daemon will be added some time in the future. But I will be unable to do any testing as I do not have the hardware for it.
### iptsd
Iptsd works on openrc and should also work on systemd but I didn't test it.
