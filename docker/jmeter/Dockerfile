FROM justb4/jmeter:latest

WORKDIR /jmeter

RUN apk update && \
    apk add --no-cache \
    python3 \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /jmeter/test-plans /jmeter/results

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

RUN echo '#!/bin/sh' > /start.sh && \
    echo 'set -e' >> /start.sh && \
    echo 'cd /jmeter/results && python3 -m http.server 6001 &' >> /start.sh && \
    echo 'HTTP_SERVER_PID=$!' >> /start.sh && \
    echo '' >> /start.sh && \
    echo 'freeMem=`awk '"'"'/MemFree/ { print int($2/1024) }'"'"' /proc/meminfo`' >> /start.sh && \
    echo 's=$(($freeMem/10*8))' >> /start.sh && \
    echo 'x=$(($freeMem/10*8))' >> /start.sh && \
    echo 'n=$(($freeMem/10*2))' >> /start.sh && \
    echo 'export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"' >> /start.sh && \
    echo '' >> /start.sh && \
    echo 'echo "START Running Jmeter on `date`"' >> /start.sh && \
    echo 'echo "JVM_ARGS=${JVM_ARGS}"' >> /start.sh && \
    echo '' >> /start.sh && \
    echo 'if [ $# -eq 0 ]; then' >> /start.sh && \
    echo '    echo "Running all test plans from /jmeter/test-plans"' >> /start.sh && \
    echo '    mkdir -p /jmeter/results' >> /start.sh && \
    echo '    timestamp=$(date +%Y%m%d_%H%M%S)' >> /start.sh && \
    echo '    for testplan in /jmeter/test-plans/*.jmx; do' >> /start.sh && \
    echo '        if [ -f "$testplan" ]; then' >> /start.sh && \
    echo '            testname=$(basename "$testplan" .jmx)' >> /start.sh && \
    echo '            results_file="/jmeter/results/${testname}_${timestamp}.jtl"' >> /start.sh && \
    echo '            report_dir="/jmeter/results/${testname}-report_${timestamp}"' >> /start.sh && \
    echo '            echo "Running test plan: $testplan"' >> /start.sh && \
    echo '            echo "Results: $results_file"' >> /start.sh && \
    echo '            echo "HTML Report: $report_dir"' >> /start.sh && \
    echo '            jmeter -n -f -t "$testplan" -l "$results_file" -e -o "$report_dir"' >> /start.sh && \
    echo '            echo "Completed: $testname"' >> /start.sh && \
    echo '        fi' >> /start.sh && \
    echo '    done' >> /start.sh && \
    echo '    echo "All test plans completed. Access HTML reports at http://localhost:6001"' >> /start.sh && \
    echo '    echo "Container will keep running to serve reports. Press Ctrl+C to stop."' >> /start.sh && \
    echo '    while true; do sleep 3600; done' >> /start.sh && \
    echo 'else' >> /start.sh && \
    echo '    jmeter -n "$@"' >> /start.sh && \
    echo 'fi' >> /start.sh && \
    echo 'echo "END Running Jmeter on `date`"' >> /start.sh && \
    chmod +x /start.sh

VOLUME ["/jmeter/test-plans", "/jmeter/results"]

EXPOSE 6001

ENTRYPOINT ["/start.sh"]

