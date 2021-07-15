### Summary:                                                                                                       

Since these are CAs for mTLS scenarios and building trust internally, separate CAs should be created for each environment.
Main reason is a service in one deployment should not trust service in another deployment.
For example:
A service from product A should not trust a service from product B
A service in product A Production should not trust a service in product A Dev. 

## Pre-requisites:                                                                                                

Install openssl
Install pwgen


## Risks / Customer Impact                                                                                       

The passphrase used to create the CA key should be stored highly confidentially, as any entity with access to
this key can generate certificates that would certify unknown hosts as trusted. It is vitally important to protect the integrity of your certificate.

