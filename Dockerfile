FROM ubuntu:20.04
RUN set -ex \
    && mkdir -p /uploads /etc/apt/sources.list.d /var/cache/apt/archives/ \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get install -y \
        bash \
        default-jre \
        unzip \
        wget

ENV VERSION 4.9.1

RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD misc/start.sh /start.sh
RUN chmod a+x /start.sh
RUN mkdir /nonexistent && touch /nonexistent/.languagetool.cfg

CMD [ "/start.sh" ]
EXPOSE 80
