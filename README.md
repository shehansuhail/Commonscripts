## Summary:                                                                                                       

Since these are CAs for mTLS scenarios and building trust internally, separate CAs should be created for each environment. Main reason is that a service in one deployment should not trust a service in another deployment.
For example:

A service from product A should not trust a service from product B

A service in product A Production should not trust a service in product A Dev.


## How to Install the tool:
---------------------------------------------------------------------------------------------------------------------------
### Open the terminal and type following commands.

1. ##### apt update
2. ##### apt install git
3. ##### git clone https://github.com/shehansuhail/Commonscripts.git
4. ##### cd Commonscripts/
5. ##### chmod +x ca.sh
6. ##### sh ca.sh or use ./ca.sh

---------------------------------------------------------------------------------------------------------------------------
## Pre-requisites 

### - Install openssl  
-Linux - https://www.tecmint.com/install-openssl-from-source-in-centos-ubuntu/

-MAC   - https://yasar-yy.medium.com/installing-openssl-library-on-macos-catalina-6777a2e238a6

### - Install pwgen

- Linux https://ubuntu.pkgs.org/18.04/ubuntu-universe-amd64/pwgen_2.08-1_amd64.deb.html
- MAC   https://brewinstall.org/install-pwgen-on-mac-with-brew/

----------------------------------------------------------------------------------------------------------------------------

![image](https://user-images.githubusercontent.com/83179294/125737894-9c847fc9-c3b5-4fd3-bd53-efcd304d3c7d.png)


## Risks / Customer Impact                                                                                       

The passphrase used to create the CA key should be stored highly confidentially, as any entity with access to
this key can generate certificates that would certify unknown hosts as trusted. It is vitally important to 
protect the integrity of your certificate.

