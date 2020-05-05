#!/bin/bash

EXTRAOPTIONS=""
[ -d "/ngrams" ] && EXTRAOPTIONS=" --languageModel /ngrams "

echo java -cp languagetool-server.jar org.languagetool.server.HTTPServer --port 8081 --public --allow-origin '*' ${EXTRAOPTIONS}
exec java -cp languagetool-server.jar org.languagetool.server.HTTPServer --port 8081 --public --allow-origin '*' ${EXTRAOPTIONS}
