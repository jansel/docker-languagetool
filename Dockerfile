FROM openjdk:14-alpine
RUN apk add --no-cache libgomp gcompat libstdc++

ENV VERSION 4.9.1
RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

ADD misc/start.sh /start.sh
WORKDIR /LanguageTool-$VERSION
USER nobody
CMD [ "sh",  "/start.sh" ]
EXPOSE 8081
