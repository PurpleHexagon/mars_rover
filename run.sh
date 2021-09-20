#!/bin/bash

echo -e "Running manual test cases\n"

FILES="cases/inputs/*"
for input_filename in $FILES
do
    echo -e "Running for case:\n"
    cat $input_filename

    echo -e "\n"
    echo -e "Outputs: \n"
    mix run -e="Run.main" < $input_filename

    actual_output=`mix run -e="Run.main" < $input_filename`

    output_filename=$(echo "$input_filename" | sed "s/input/output/")
    output_filename=$(echo "$output_filename" | sed "s/input/output/")

    output=`cat $output_filename`

    if [ "$output"="$actual_output" ]; then
        echo "Passed"
    else
        echo "Failed"
    fi

    echo -e "\n"
done
