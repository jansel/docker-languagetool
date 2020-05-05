
prepare:
	sudo apt-get -qq -y install curl

build:
	docker build --pull -t jansel/docker-languagetool .

test:
	echo "get all languages"
	curl -X GET --header 'Accept: application/json' 'http://localhost:8081/v2/languages'

	echo "test en-US"
	curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'text=hello%20woorld&language=en-US&motherTongue=en-US&enabledOnly=false' 'http://localhost:8081/v2/check'

	echo "test ngrams"
	curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' \
		-d 'text=I%20can%20not%20remember%20how%20to%20go%20their.&language=en-US&motherTongue=en-US&enabledOnly=false' 'http://localhost:8081/v2/check' \
		| grep 'Statistics suggests that'

stop:
	docker stop languagetool
	docker rm languagetool

start: ngrams build
	docker run -d --name languagetool -p 127.0.0.1:8081:8081 -v `pwd`/ngrams:/ngrams:ro --restart=unless-stopped jansel/docker-languagetool

ngrams:
	test -d ngrams || ( \
		which wget && \
		mkdir ngrams && \
		cd ngrams && \
		wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip && \
		unzip ngrams-en-20150817.zip && \
		rm -f ngrams-en-20150817.zip)

restart:
	make stop || true
	make start
