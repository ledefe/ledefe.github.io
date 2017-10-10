export JAVA_HOME=/usr/local/java
cd `dirname $0`
./tail_stop.sh
nohup bin/logstash -f config/filebeat_logstash_es.conf  >/dev/null 2>&1 &
echo $! > agent.pid
echo 'logstash started,pid:' $! 

