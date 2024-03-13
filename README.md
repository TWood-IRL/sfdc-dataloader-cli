# Dataloader CLI

Generate Dataloader.key file and put in `conf` directory

1) Generate the private key to encrypt the password
```bash
$ bin/encrypt.sh -k [keyfile]  
```

2) Copy the output from Step 1 above to conf/private.key (replacing the text in there)
Encrypt the salesforce password (+security token, if required) using the generated private key

```bash
$ bin/encrypt.sh -e "xxxxxxxxxxx" dataLoader/private.key
```

