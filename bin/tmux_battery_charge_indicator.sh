#!/bin/bash

HEART='♥'

battery_info=`ioreg -rc AppleSmartBattery`
current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | cut -d ' ' -f 3)
total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | cut -d ' ' -f 3)

charged_slots=$(echo "(($current_charge/$total_charge)*10)+1" | bc -l | cut -d '.' -f 1)
if [[ $charged_slots -gt 10 ]]; then
  charged_slots=10
fi

echo -n '#[fg=red]'
for i in `seq 1 $charged_slots`; do echo -n "$HEART"; done

if [[ $charged_slots -lt 10 ]]; then
  echo -n '#[fg=white]'
  for i in `seq 1 $(echo "10-$charged_slots" | bc)`; do echo -n "$HEART"; done
fi
