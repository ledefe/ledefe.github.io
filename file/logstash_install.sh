while getopts "h:" opt; do
 case $opt in
  h)
   hosts=$OPTARG;
   echo "the es host is $hosts";;
 \?)
   echo "Invalid option: -$OPTARG";
   exit -1;;
esac
done

if [ ! -n "$hosts" ]; then 
 echo "-h must to set for es http hosts,example '-h 127.0.0.1:9200,127.0.0.2:9200'"
 exit -1
fi

dir=`dirname $0`
cd $dir
logstashDir=/usr/local
tar -zxvf logstash_server.tar.gz -C ${logstashDir}
result=$(grep "${logstashDir}/logstash_server/logstash-5.3.0/tail_start.sh" /etc/rc.d/rc.local)
if echo $result |grep -q "${logstashDir}/logstash_server/logstash-5.3.0/tail_start.sh"; then
  echo "ignore auto setup set"
else
  echo '${logstashDir}/logstash_server/logstash-5.3.0/tail_start.sh'>>/etc/rc.d/rc.local
fi
configFile=${logstashDir}/logstash_server/logstash-5.3.0/config/filebeat_logstash_es.conf
sed -i "s#^      hosts => .*#      hosts => \"${hosts}\"#g" ${configFile}
chmod +x /etc/rc.d/rc.local
