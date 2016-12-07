FROM alpine

#RUN cat /etc/apk/repositories| sed 's@main@testing@g' > /testing && cat testing >> /etc/apk/repositories

RUN apk add transmission-daemon transmission-cli --update && \
 rm -rf /var/cache/apk/*

RUN adduser -D user

# volumes and ports
VOLUME /config /downloads
EXPOSE 51413/tcp 9091/tcp

COPY noarch/*.sh /usr/bin/
RUN chmod 755 /usr/bin/*sh

RUN mkdir -p /home/user/.config/transmission-daemon

ENV APP_BIN=transmission-daemon
ENV APP_ARGS="-f"

ENTRYPOINT ["entrypoint.sh"]
#CMD -c /config
