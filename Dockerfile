FROM eclipse-temurin:21-alpine
RUN apk add --no-cache libgomp gcompat libstdc++

ENV VERSION 6.5

RUN wget https://www.languagetool.org/download/LanguageTool-$VERSION.zip && \
    unzip LanguageTool-$VERSION.zip && \
    rm LanguageTool-$VERSION.zip && \
    mv LanguageTool-* LanguageTool

# ADD ./LanguageTool-$VERSION.zip LanguageTool-$VERSION.zip
# RUN unzip LanguageTool-$VERSION.zip && \
#     rm LanguageTool-$VERSION.zip && \
#     mv LanguageTool-* LanguageTool

WORKDIR /LanguageTool

ADD misc/start.sh /start.sh
CMD [ "sh", "/start.sh" ]
USER nobody
EXPOSE 8081
