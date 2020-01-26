#!/usr/bin/env ash

# MAINTAINER Barcus <barcus@tou.nu>

if [ ! -f /etc/bareos/bareos-config.control ]
  then
  tar xfvz /bareos-sd.tgz

  # Update bareos-storage configs
  sed -i "s#Password = .*#Password = \"${BAREOS_SD_PASSWORD}\"#" /etc/bareos/bareos-sd.d/director/bareos-dir.conf

  # correct owner of volume
  chown -R bareos /var/lib/bareos
  chown -R bareos /etc/bareos

  # Control file
  touch /etc/bareos/bareos-config.control
fi

find /etc/bareos ! -user bareos -exec chown bareos {} \;
exec "$@"
