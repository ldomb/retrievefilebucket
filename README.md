Retrievefilefrombucket
==================

This script can search the filesystem for files which were changed by puppet and shows how you can restore them.
 ```
Usage: 
Example: basename $0 file
Example: `basename $0` path
# retrievfilesfrombucket.sh /
Searching for local backups of file / (this may take some time)...
=====================================================================================
/etc/yum.repos.d/epel.repo      4cd77946d1b5176987036e8fb382ce2d        2014-04-07 12:09:31.099198397 -0500
/etc/anacrontab 8241db83d5edf01c71734e41e383e205        2014-03-31 15:52:59.953977437 -0500
/etc/crontab    4f2aaa54c48dda350f75da151f79ae57        2014-03-31 15:52:59.568977035 -0500

Backup(s) were found!
 * To view the contents of the file, issue this command:
 puppet filebucket -b /var/lib/puppet/clientbucket get <md5sum>

 * To restore the file, issue this command:
 puppet filebucket restore -b /var/lib/puppet/clientbucket /path/to/new/file <md5sum>
```
