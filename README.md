# Using Arista EOS ZTP Server

This repository contains the "minimum viable setup" for using the [Arista ZTP Server](https://github.com/arista-eosplus/ztpserver) to bootstrap
a collection of EOS devices using the same EOS software image and configuration file.  This
use-case is not intended for "production" scenarios but rather to simply install EOS images quickly.

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

