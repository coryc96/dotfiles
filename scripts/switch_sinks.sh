#!/bin/bash
#active=$(pactl list sinks | grep "Active Port: analog" | awk -F ':' '/\w*/ {print $2}' | xargs)
#devices=$(pactl list sinks | grep -e 'Line' -e 'Headphones' | awk -F ':' '/\w*/ {print $1}')
#LineOut=$(echo $devices | awk '{print $1}')
#Headphones=$(echo $devices | awk '{print $2}')
#deviceArray=("$LineOut" "$Headphones")
#for device in "${deviceArray[@]}"
#do
#if [ "$device" != "$active" ]; then pactl set-sink-port 0 $device; fi
#done

activeInput=$(pactl list sink-inputs short | awk '{print $1}')
activeSink=$(pactl list sink-inputs short | awk '{print $2}')
inactiveSink=$(pactl list sinks short | grep "analog" | grep -v "RUNNING" | awk '{print $1}')
pactl set-default-sink $inactiveSink
pactl move-sink-input $activeInput $inactiveSink
