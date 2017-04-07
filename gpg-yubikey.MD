####How to install and maintain GPG keys on my Yubikey
From: [PGP and SSH on Yubikey](https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/)

We want to keep out Master Key on a USB drive that a) doesn't leave the house or office and b) is rarely connected to a computer.  You can also use a livecd and airgapped machine for even more security.  I deem for my attack profile that having the Master Key offline most of the time is good enough.  This may change in the future. My USB drive is also used to back up sensitive info so gpg stuff is under gnupg/

```bash
#Store Master key on USB drive
mv .gnupg .gnupg.orig
ln -s /PATHTOUSBDRIVE/gnupg .gnupg

#Check gpg.conf for strong hash and encryption preferences
cert-digest-algo SHA512
default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES

#generate a Master key if there isn't one

#if we have a secret key


