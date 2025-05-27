# What is this thing?

This code is a simple UEFI application used to test keyboard / display latency
in VDI sessions. Specifically this was developed to test the Kerbside
(https://github.com/shakenfist/kerbside) SPICE VDI proxy, using a custom SPICE
client and this UEFI application running as the "boot loader" of a virtual
machine hosted on the cloud under test.

## Derivation

This code is to a large extent a derived work of Queso Fuego's UEFI programming
YouTube playlist (https://www.youtube.com/playlist?list=PLT7NbkyNWaqZYHNLtOZ1MNxOt8myP5K0p)
and specifically the associated git repository (https://github.com/queso-fuego/uefi-dev).

## Licenses

The code this is based on is public domain licensed. I have therefore licensed
this repository under the same license.

# Usage

## I just want the test target, not to compile stuff

A build version of this binary, packaged as a qcow2 file for convenience, is
archived at https://images.shakenfist.com. For most use cases its simpler to
just download that image than recompile everything.

## No, I really do want to build the thing

Firstly clone this repository and then fetch the submodules:

```
# git clone https://github.com/shakenfist/uefi-latency-guest
# cd uefi-latency-guest
# git pull --recurse-submodules
```
