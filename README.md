# backup

This repository contains a ruby 2.3 image to run the [backup gem](http://backup.github.io/backup/v4/).

## usage

Just run the docker container inside a kubernetes environment. You can find some examples in the
`kubernetes-examples/` folder.

## configuration

Everything can be specified by ENV:

```sh
# FTP Configuration, used if FTP_SERVER is present
FTP_USERNAME=
FTP_PASSWORD=
FTP_SERVER=
FTP_PORT=21
FTP_KEEP=3
FTP_PATH=/home/

# SFTP Configuration, used if SFTP_SERVER is present
SFTP_USERNAME=
SFTP_PASSWORD=
SFTP_SERVER=
SFTP_PORT=22
SFTP_KEEP=3
SFTP_PATH=/home/

# Backup Folders
BACKUP_FOLDER=/etc/,/home

# encrypt the backup if the password is set
BACKUP_PASSWORD=

# slack or mattermost Configuration
# leave empty if you don't need a notification
SLACK_URL=
SLACK_NOTIFY_SUCCESS=true
SLACK_NOTIFY_WARNING=true
SLACK_NOTIFY_FAILURE=true

# psql Configuration, used if PSQL_SERVER is present
PSQL_DATABASE=
PSQL_USERNAME=
PSQL_PASSWORD=
PSQL_SERVER=
PSQL_PORT=5432
```

You need at least to configure:
* FTP or SFTP Server
* PSQL and/or a folder
* Slack is optional but useful - mattermost will work to
* you can setup the Compression or Encryption