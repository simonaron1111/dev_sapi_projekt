#!/bin/sh

set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"

# Run JMeter in non-GUI mode
if [ $# -eq 0 ]; then
    echo "Running all test plans from /jmeter/test-plans"
    mkdir -p /jmeter/results
    
    timestamp=$(date +%Y%m%d_%H%M%S)
    
    for testplan in /jmeter/test-plans/*.jmx; do
        if [ -f "$testplan" ]; then
            testname=$(basename "$testplan" .jmx)
            results_file="/jmeter/results/${testname}_${timestamp}.jtl"
            report_dir="/jmeter/results/${testname}-report_${timestamp}"
            
            echo "Running test plan: $testplan"
            echo "Results: $results_file"
            echo "HTML Report: $report_dir"
            
            jmeter -n -f -t "$testplan" -l "$results_file" -e -o "$report_dir"
            
            echo "Completed: $testname"
        fi
    done
    
    echo "All test plans completed. Access HTML reports at http://localhost:6001"
    echo "Container will keep running to serve reports. Press Ctrl+C to stop."
    # Keep container running
    while true; do sleep 3600; done
else
    jmeter -n "$@"
fi
echo "END Running Jmeter on `date`"