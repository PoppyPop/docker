#!/bin/sh
#

# Bootstrap
if [ ! -f /etc/cfssl/ca.pem ] && [ ! -f /etc/cfssl/bootstrap ]; then 
	# No config and no bootstrap tampering
	sleep $(( ( RANDOM % 10 )  + 1 ))
fi

if [ -f /etc/cfssl/bootstrap ]; then 
	echo "Waiting 60sec. to bootstrap finish"
	x=1
	while [ $x -le 60 ] && [ -f /etc/cfssl/bootstrap ]
	do
	  sleep 1
	  x=$(( $x + 1 ))
	done
fi

if [ ! -f /etc/cfssl/ca.pem ]; then 
	touch /etc/cfssl/bootstrap
	
	cfssl genkey -initca ca.json | cfssljson -bare ca
	mkdir capub
	mv ca.crt capub/ca.pem
	
	cfssl gencert -ca capub/ca.pem -ca-key ca-key.pem -config="config.json" -profile="intermediate" intermediate.json | cfssljson -bare signing-ca
	
	cfssl gencert -ca signing-ca.pem -ca-key signing-ca-key.pem -config="config.json" -profile="ocsp" ocsp.json| cfssljson -bare ocsp-ca

	cfssl ocspdump -db-config db-config.json > ocspdump.txt
	
	rm /etc/cfssl/bootstrap
fi

if [ "$@" = "server" ]; then 
	exec cfssl serve -db-config="db-config.json" -ca-key=signing-ca-key.pem -ca=signing-ca.pem -config="config.json" -responder=ocsp-ca.pem -responder-key=ocsp-ca-key.pem -address=0.0.0.0	-port=8888
elif [ "$@" = "ocsp" ]; then 
	exec cfssl ocspserve -address=0.0.0.0 -port=8889 -responses=ocspdump.txt
elif [ "$@" = "httpca" ]; then 
	exec httpd -h /etc/cfssl/capub -p 8887 -f
elif [ "$@" = "ocspdump" ]; then 
	sleep 1m
	while true; do
		echo `date "+%Y/%m/%d %H:%M:%S"` "[INFO] OCSP Dumping"
		cfssl ocspdump -db-config db-config.json > ocspdump.txt
		sleep 1d
	done
elif [ "$@" != "" ]; then
	exec "$@"
else
	echo "No action, quit"
	exit 1
fi