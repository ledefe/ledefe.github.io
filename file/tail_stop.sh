pid=`ps -ef|grep filebeat_logstash_es.conf|grep -v 'grep' |awk '{print $2}'`

echo $pid

pidStatus=`ps --no-heading ${pid} | wc -l`
 
if [ $pidStatus -eq 1 ] ; then

    echo 'logstash  already exsit with pid:' $pid ' and stopping'
    kill $pid       
else
     echo 'logstash  not exsit...'
fi

