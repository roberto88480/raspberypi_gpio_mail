#!/bin/bash

GPIOPIN=17
TIMEOUT=$((60*12))
MESSAGE="GPIO PIN 17 hat Kontakt."
LASTMAIL=.gpio_trigger_last

echo ${GPIOPIN} > /sys/class/gpio/export
sleep 1
echo in > /sys/class/gpio/gpio${GPIOPIN}/direction

if [[ $(cat /sys/class/gpio/gpio${GPIOPIN}/value) -gt 0 ]]
then
	if [ ! -f ${LASTMAIL} ] || [[ $(find "${LASTMAIL}" -mmin +${TIMEOUT} -print) ]]
	then
		echo "${MESSAGE}"
		touch ${LASTMAIL}
	fi
fi

echo ${GPIOPIN} > /sys/class/gpio/unexport
