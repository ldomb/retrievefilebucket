green="$(tput setaf 2)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"

if [ ${#@} == 0 ]; then
    echo "${green}#################################################################"
    echo "# This script is used to retrieve backups of files that were    #"
    echo "# updated by puppet but which you might want to retrieve or     #"
    echo "# reinstate. Remember that unless you add the retrieved file    #"
    echo "# back into puppet itself, it is likely to be overwritten again.#"
    echo "#                                                               #"
    echo "# Usage: `basename $0` file_to_look_for               #" 
    echo "# Example: `basename $0` /                            #"
    echo "################################################################# ${reset}"
else
    file=$1
    BUCKETDIR=$( puppet config print clientbucketdir )
    PREFIX="* "
    entries_found=0
    echo "Searching for local backups of file $file (this may take some time)..."
    echo "====================================================================================="
    for f in $( find $BUCKETDIR -type f -name paths -exec grep -l $file {} \; |xargs -r ls -t);
    do
      md5sum=$( basename $(dirname $f))
      filename=$(< $f )
      modify_time=$(stat --format '%y' $f)
      echo -e "$filename\t${red}$md5sum\t${reset}$modify_time"
      entries_found=1
    done
  if [ $entries_found -eq 1 ]; then
    echo ""
    echo "${green}Backup(s) were found!${reset}                     "
    echo " * To view the contents of the file, issue this command:  "
    echo " puppet filebucket -b $BUCKETDIR get ${red}<md5sum>${reset}"
    echo "                                                          "
    echo " * To restore the file, issue this command:               "
    echo " puppet filebucket restore -b $BUCKETDIR /path/to/new/file ${red}<md5sum>${reset}"
    echo "====================================================================================="
  else
    echo "No entries were found. Exiting."
  fi
fi
