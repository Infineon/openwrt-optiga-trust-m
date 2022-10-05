# OpenWRT tools and examples</br> for OPTIGA™ Trust M1/M3 security solution

This is the repository for OPTIGA™ Trust M on OpenWrt. OpenWrt is a highly extensible GNU/Linux distribution for embedded devices (typically wireless routers and gateway).  Instead of trying to create a single, static firmware, OpenWrt provides a fully writable filesystem with package management. In this repository, the steps to integrate OPTIGA™ Trust M1/M3 into OpenWrt are shown. Together with OPTIGA™ Trust M a hardware-based security solution and its set of security features, it can be used to perform authentication, crypto operations,  and serve as a hardware root of trust to protect the wireless routers or gateway.

# Table of content

* [Software requirements](#software-requirements)
* [Hardware requirements](#hardware-requirements)
* [Getting Started](#getting-started)
   * [Getting the Code from Github](#getting-the-code-from-github)
   * [Image configuration](#image-configuration)
   * [Building Images](#building-images)
   * [Running the commands](#running-the-commands)
   * [Make tips](#make-tips)
      * [Building single packages](#building-single-packages)

## Software requirements:

Following is the software components to build the tools in Ubuntu:

```
sudo apt update
```

```sudo apt install build-essential ccache ecj fastjar file g++ gawk \
gettext git java-propose-classpath libelf-dev libncurses5-dev \
libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
python3-distutils python3-setuptools python3-dev rsync subversion \
swig time xsltproc zlib1g-dev 
```

## Hardware requirements:

- Raspberry PI 3/4 on Linux kernel >= 4.19

- Micro SD card (≥8GB)

- [S2GO SECURITY OPTIGA™ Trust M](https://www.infineon.com/cms/en/product/evaluation-boards/s2go-security-optiga-m/)

- [Shield2Go Adapter for Raspberry Pi](https://www.infineon.com/cms/en/product/evaluation-boards/s2go-adapter-rasp-pi-iot/)

  ![image](https://user-images.githubusercontent.com/12692378/193815251-a29fc0dd-be7c-42e0-be4d-b0f42ac4e534.png)

## Getting Started

### Getting the Code from Github

- Do everything as a normal user: do not log in as root and do not use sudo.
- Do not build in a directory that has spaces in its full path.
- Download and update the sources
  ```
  git clone https://git.openwrt.org/openwrt/openwrt.git openwrt
  ```
  ```
  cd openwrt
  ```
  ```
  git pull
  ```
- Select a specific code revision
  ```
  git checkout v21.02.2
  ```
- Update the feeds
  ```
  ./scripts/feeds update -a
  ```
  ```
  ./scripts/feeds install -a
  ```
- Getting the initial code for optiga trust M from Github:
  ```
  git clone --recurse-submodules https://github.com/Infineon/openwrt-optiga-trust-m.git
  ```
- Copy the linux-openwrt-optiga-trust-m folder into openwrt/package:
  ![](/pictures/linux-openwrt-optiga-trust-m.png)
- Get the .config which should be the same version with the checkout branch (OpenWrt 21.02.2)
  ```
  wget https://downloads.openwrt.org/releases/21.02.2/targets/bcm27xx/bcm2710/config.buildinfo -O .config
  ```

### Image configuration

#### Make `menuconfig`

The **build system configuration interface** handles the selection of the target platform, packages to be compiled, packages to be included in the firmware file, some kernel options, etc.

Start the build system configuration interface by writing the following command in openwrt directory:

  ```
  make menuconfig
  ```
- Enable linux-optiga-trust-m for built-in
  ![](/pictures/configure-linux-optiga-package.png)
- Enable openssl-util for built-in
  ![](/pictures/configure-linux-optiga-package1.png)
- Enable  I2c support for kmod-i2c-bcm2835 under Kernel module
  ![](/pictures/configure-linux-optiga-package2.png)
- Enable openssh-sftp-server to communicate with Raspberry Pi through Ethernet cable
  ![](/pictures/configure-linux-optiga-package-ssh.png)

This will update the dependencies of your existing configuration automatically, and you can now proceed to build your updated images.

### Building images

Everything is now ready for building the image(s), which is done with one single command:

```
make -j5
```

This should compile toolchain, cross-compile sources, package packages, and generate an image ready to be flashed.

Copy the factory image to PC and burn using RPI imager:

![](/pictures/configure-linux-optiga-package3.png)

### Running the commands

Connect PC to RPI through Ethernet cable

Open Putty  and choose SSH as connection type:

![](/pictures/putty_SSH.png)

Running trustm_chipinfo and trustm_cert as the example:

![](/pictures/trustm_chipinfo.png)

## Make tips

See also: [Compiler optimization tweaks](https://forum.openwrt.org/viewtopic.php?id=35323)

`make download` will pre-download all source code for all dependencies, this will enable multi core compilation to succeed, without it it is very likely to fail. `make -j`**N** will speed up compilation by using up to **N** cores or hardware threads to speed up compilation, `make -j9` fully uses 8 cores or hardware threads.

Example of pre-downloading and building the images on a 4 core CPU:

```
make download 
make -j5
```

### Building single packages

When developing or packaging software, it is convenient to be able to build only the package 

```
make package/linux-openwrt-optiga-trust-m/{clean,compile} V=s
```

After compiling successful, you can go to openwrt/bin/packages/aarch64_cortex-a53/base to get linux-optiga-trust-m_1.0.0-1_arm_cortex-a7_neon-vfpv4.ipk.

open internet explorer and key in 192.168.1.1 and login as root, got to system-->software-->installed, you can find linux-optiga-trust-m package inside:

![](/pictures/luci.png)

You can easily remove and install there:

![](/pictures/install.png)



