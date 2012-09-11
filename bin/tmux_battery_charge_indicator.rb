#!/usr/bin/ruby

HEART = '♥'

# OPTIMIZE: Merge this into one call.
current_charge = `ioreg -rc AppleSmartBattery | grep 'CurrentCapacity' | sed 's/^ *//g' | cut -d\\  -f3`.to_f
total_charge   = `ioreg -rc AppleSmartBattery | grep 'MaxCapacity' | sed 's/^ *//g' | cut -d\\  -f3`.to_f

charge = ((current_charge / total_charge) * 10).ceil

puts "#[fg=red]#{HEART * charge}#[fg=white]#{HEART * (10 - charge)}"
