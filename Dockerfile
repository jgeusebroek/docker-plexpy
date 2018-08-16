FROM alpine:latest
MAINTAINER Jeroen Geusebroek <me@jeroengeusebroek.nl>

ENV APK_ADD="sudo git python2 py-setuptools" \
    REFRESHED_AT='2018-08-16'

RUN apk add --no-cache ${APK_ADD} && \

    # Clone Plexpy
    git clone --depth 1 https://github.com/drzoidberg33/plexpy.git /opt/plexpy

VOLUME [ "/config" ]

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod u+x  /entrypoint.sh

EXPOSE 8181

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "" ]
