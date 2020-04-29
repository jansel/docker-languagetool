
prepare:
	sudo apt-get -qq -y install curl

build:
	docker build --pull -t jansel/docker-languagetool .

test:
	echo "get all languages"
	curl -X GET --header 'Accept: application/json' 'http://localhost:8010/v2/languages'

	echo "test en-US"
	curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'text=hello%20woorld&language=en-US&motherTongue=de-DE&enabledOnly=false' 'http://localhost:8010/v2/check'

	echo "test fr"
	curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'text=hello%20woorld&language=fr&motherTongue=de-DE&enabledOnly=false' 'http://localhost:8010/v2/check'

stop:
	docker stop languagetool
	docker rm languagetool

start: ngrams
	docker run -d --name languagetool -p 127.0.0.1:8081:80 -v `pwd`/ngrams:/ngrams --restart=unless-stopped jansel/docker-languagetool

ngrams:
	test -d ngrams || ( \
		wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip && \
		mkdir ngrams && \
		cd ngrams && \
		unzip ../ngrams-en-20150817.zip && \
		rm -f ../ngrams-en-20150817.zip)

restart:
	make stop || true
	make start
