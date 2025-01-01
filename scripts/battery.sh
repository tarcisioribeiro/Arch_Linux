#!/bin/bash

# Obtém o status da bateria usando upower
battery=$(upower -i $(upower -e | grep battery) | grep -E "percentage" | awk '{print $2}')
status=$(upower -i $(upower -e | grep battery) | grep -E "state" | awk '{print $2}')

# Exibe o status da bateria
echo "$battery ($status)"
