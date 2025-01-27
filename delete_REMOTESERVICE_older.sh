#!/bin/bash

# Variables
$USER=""
$CARPETA_ORIGEN=""
$CARPETA_DESTI=""

$DESTINACIO_COPIAR_REMOTA=""

$FITXER_TEMPORAL=""
$carpeta_guardar=""
$CARPETA_clau_GPG=""

$NOM_temp=""
$NOM_clau_GPG_1=""
$NOM_clau_GPG_2=""

$CLAU_MEVA_1=""

if [ "$(id -u)" -eq 0 ]; then
    exec sudo -H -u ${USER} $0 "$@"
    echo "This is never reached.";
fi

X=$(rclone ls ${DESTINACIO_COPIAR_REMOTA} | wc -l)

while [[ $X =~ ^[0-9]+$ && $X -gt 4 ]]; do
     X=$(rclone ls ${DESTINACIO_COPIAR_REMOTA} | wc -l)
     NOM_ELIMINAR=$(rclone ls ${DESTINACIO_COPIAR_REMOTA} | head -n 1 | sed -e 's/ /;/g' | sed -e 's/^\([;]*\)//g' | sed -e 's/;;//g' | cut -d ";" -f2)
     if [[ $X -le 4 ]]; then
          break  # Això fa que surti del bucle quan $X és menor o igual a 4
     fi
     rclone deletefile ${DESTINACIO_COPIAR_REMOTA}/$NOM_ELIMINAR
     echo "Eliminat:  $NOM_ELIMINAR"
     unset NOM_ELIMINAR
     sleep 2
done

printf "Neteja perfils FIREFOX antic (rclone - dropbox) feta en data:  $(date)" | mail -s "rclone NETEJA PERFILS (FIREFOX)" -F user@localhost
