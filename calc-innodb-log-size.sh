echo "Calculating your recommended innodb_log_file_size."
echo "You will be asked your MySQL user's password twice."
echo "Taking the first read."
FLS=`mysql --raw -p -e "pager grep sequence; show engine innodb status;" | awk '/Log sequence/ {print $5}'`
echo "Patience please while we wait to take another read in 60 seconds."
sleep 60
echo "Your patience is being rewarded."
SLS=`mysql --raw -p -e "pager grep sequence; show engine innodb status;" | awk '/Log sequence/ {print $5}'`
LFS=`mysql -p -e "select truncate(($FLS - $SLS) / 1024 / 1024 * 60 / 2,0) as MB_per_min;" | grep -E '[0-9]'`
echo "You're recommended innodb_log_file_size is:"
echo $LFS"M"
echo "For more information please see the following percona articles, they're old but still useful:"
echo "https://www.percona.com/blog/2008/11/21/how-to-calculate-a-good-innodb-log-file-size/"
echo "https://www.percona.com/blog/2006/07/03/choosing-proper-innodb_log_file_size/"
