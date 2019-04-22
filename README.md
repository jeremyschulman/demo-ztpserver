# Using Arista EOS ZTP Server

This repository contains the "minimum viable setup" for using the [Arista ZTP Server](https://github.com/arista-eosplus/ztpserver) to bootstrap
a collection of EOS devices using the same EOS software image and configuration file.  This
use-case is not intended for "production" scenarios but rather to simply install EOS images quickly.

Total time to setup ZTP Server using this repo: 5 minutes.

# Demo Use Case

    As a network engineer, I need to intall the same version of EOS on all devices in my lab.  
    I also want to configure the devices so that the following is true:
    
       * Leave the `admin` user with password `admin`
       * Leave the Management1 set to DHCP
       * Enable SCP
       * Enable HTTP eAPI

    I want to run the ZTPServer on my laptop.
    I want to run the DHCP sever on my laptop.
    
# Before You Begin

This use-case requires that you install [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) on your laptop.  
You can choose to use any DHCP server you prefer, but this repo uses dnsmasq for the following reasons:

   * Lightweight DHCP server
   * Provides DNS services if you want/need it
   * Provide very good logging and troubleshooting
   

You should create a Python virtual environment for installing the ztpserver package.  The following 
assumes that Python 2.7 is your default installation. In a laptop terminal, run these
commands:

````bash
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
````

The ztpserver will be install in the virtualenv directory.  The following command
creates the environment variable used by `ztps` to locate the installed files.  You
can either keep this value, or copy the installed files to another location of your
choice.   This variable is also set in the [run-ztps.sh](run-ztps.sh) script. 

````bash
export ZTPS_DEFAULT_DATAROOT=${VIRTUAL_ENV}/lib/python2.7/site-packages/usr/share/ztpserver
````

# Demo ZTP Server Setup

For the purpose of this demonstration:

    For my lab environment, I want the DHCP server and ZTP server to be my laptop with the
    assigned IP 192.168.10.250.
    
    I want my DHCP server to offer IPs in the range 192.168.10.100 - 200.
    
    I want all devices to use EOS version 4.21.5F
    

### Changing IP addresses

If you want to change the IP addresses used in this demo, you will need to make the following changes:

   * `dnsmasq.conf` 
   * `ztpserver.conf`
   
### Setup of ZTP Server Files

This repo contains a number of files that need to be copied into the ZTP server
installation.  Presuming you have setup `ZTPS_DEFAULT_DATAROOT`, you can run
these commands:

````bash
cp neighbordb $ZTPS_DEFAULT_DATAROOT
cp -r files $ZTPS_DEFAULT_DATAROOT
cp -r definitions $ZTPS_DEFAULT_DATAROOT
````

The `neighbordb` is configured to match any EOS device.  There are two patterns defined:

   * Match any EOS device that does not have any interfaces connected (_isolated_)
   * Match any EOS device that has any interfaces connected
   
If you want to change these pattern matching constraints, refer to the ZTP server documentation [here](https://ztpserver.readthedocs.io/en/master/config.html#dynamic-provisioning-neighbordb).

### EOS Image Files

You will need to provide your own EOS image (*.swi) files.  These files need to be copied into the
`files/images` directory.  There is a text-placeholder file for illustration purposes only.

### EOS Configuration File

The EOS configuration file used in this demo is located in [files/configs/all](files/configs/all).  The contents
of this file will be load-replaced onto the EOS device.  

# Running

You will need to have two terminal windows open.  Once must have the virtualenv active 
so that you can run the `ztps` command.  The other does not require virtualenv.

In the virtualenv terminal, execute the script to start the ZTP Server:

````bash
./run-ztps.sh
````

In the 2nd terminal, start the DHCP server:

```bash
./run-dnsmasq.sh
```

Presuming that you have your laptop connected to the EOS devices in some manner, you should start 
seeing log messages in both windows.

Good luck!

# Question / Comments

Please open issues in this repo and I will try to answer them in a timely manner.
   