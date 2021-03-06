FROM openjdk:14-alpine
RUN apk add --no-cache libgomp gcompat libstdc++

ENV VERSION 5.4

# RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
ADD ./LanguageTool-$VERSION.zip LanguageTool-$VERSION.zip
RUN unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8081
