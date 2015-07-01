#!/bin/bash

elasticSearch ()
{
	cd
	curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.5.1.tar.gz
	tar xzvf elasticsearch-1.5.1.tar.gz

	nodeMaster="true"
	nodeData="true"

	echo -n "input cluster name => "
	read clusterName

	echo -n "input node name => "
	read nodeName

	echo -n "Master only?(y/n) => "
	read answer1

	if [ "$answer1" = "n" -o "$answer1" = "N"  ]
	then
		echo -n "Master node?(y/n) => "
		read answer2
	
		if [ "$answer2" = "y" -o "$answer1" = "Y"  ]
		then
			nodeData="false"
		elif [ "$answer2" = "n" -o "$answer1" = "N" ]
		then
			nodeMaster="false"
		fi
	fi

	cat << EOM > elasticsearch-1.5.1/config/elasticsearch.yml
cluster.name: "$clusterName"
node.name: "$nodeName"
node.master: $nodeMaster
node.data: $nodeData
EOM
}

logstash ()
{
	cd
	curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
	tar xzvf logstash-1.4.2.tar.gz
}

logForwarder ()
{
	cd
	sudo apt-get install -y golang
	sudo apt-get install -y make
	sudo apt-get install -y git
	git clone git://github.com/elasticsearch/logstash-forwarder.git
	cd logstash-forwarder
	go build -o logstash-forwarder
	
	sudo apt-get install ruby-dev
	gem install bundler
	bundle install
	
	make deb
	dpkg -i logstash-forwarder_0.4.0_amd64.deb
}


cat << EOM 
ELK installer. Choose 1 item.
1. elastic search install
2. logstash install
3. logstash-forwarder install

EOM

echo -n "enter number ==>  "
read num

case $num in
	"1") elasticSearch;;
	"2") logstash;;
	"3") logForwarder;;
	*) echo "installer exit";;
esac

exit 0