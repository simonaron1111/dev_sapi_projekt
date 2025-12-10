FROM justb4/jmeter:latest

WORKDIR /jmeter

RUN apk update && \
    apk add --no-cache \
    python3 \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /jmeter/test-plans /jmeter/results

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

RUN echo "#!/bin/sh" > /start.sh && \
    echo "cd /jmeter/results && python3 -m http.server 6001 &" >> /start.sh && \
    echo "HTTP_SERVER_PID=\$!" >> /start.sh && \
    echo "exec /launch.sh \"\$@\"" >> /start.sh && \
    chmod +x /start.sh

VOLUME ["/jmeter/test-plans", "/jmeter/results"]

EXPOSE 6001

ENTRYPOINT ["/start.sh"]

