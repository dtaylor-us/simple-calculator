#!/usr/bin/env bash

operation_history_file="operation_history.txt"

# Function to log messages to the operation_history.txt file
log_message() {
  echo "$1" >>"$operation_history_file"
  echo "$1"
}

calculate() {
  log_message "Enter an arithmetic operation or type 'quit' to quit:"

  read -r -a operation_input
  echo "${operation_input[@]}" >>"$operation_history_file"

  if [[ "${operation_input[0]}" == "quit" ]]; then
    log_message "Goodbye!"
    exit 0
  fi

  num_re='^[+-]?[0-9]+([.][0-9]+)?$'

  first_number="${operation_input[0]}"
  operator="${operation_input[1]}"
  second_number="${operation_input[2]}"

  if ! [[ "$first_number" =~ $num_re && "$second_number" =~ $num_re && "$operator" =~ ^[-+*/%^]$ ]]; then
    log_message "Operation check failed!"
  elif [ "${#operation_input[@]}" -ne 3 ]; then
    log_message "Operation check failed!"

  else
    result=$(echo "scale=2; $first_number $operator $second_number" | bc)
    log_message "$result"
  fi
}

log_message "Welcome to the basic calculator!"
while true; do
  calculate
done
