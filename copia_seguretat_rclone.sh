#!/usr/bin/bash

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


tar cvf ${FITXER_TEMPORAL}.tar ${CARPETA_ORIGEN}/${carpeta_guardar}/
cd ${CARPETA_DESTI}

gpgtar --encrypt --recipient ${CLAU_MEVA_1} ${FITXER_TEMPORAL} >> ${NOM_temp}_$(date +'$Y_%m_%d').gtar
# Signar fitxer amb gpgtar no funciona bé
gpg2 -sb --armor --pinentry-mode=loopback --passphrase-file ${CARPETA_clau_GPG}/${NOM_clau_GPG_1} ${NOM_temp}_$(date +'%Y_%m_%d').gtar
rm ${NOM_temp}.tar


rclone copy ${CARPETA_DESTI}/${NOM_temp}_$(date +'%Y_%m_%d').gtar ${DESTINACIO_COPIAR_REMOTA}
rclone copy ${CARPETA_DESTI}/${NOM_temp}_$(date +'%Y_%m_%d').gtar.asc ${DESTINACIO_COPIAR_REMOTA}

printf "Copia seguretat ${carpeta_guardar} (rclone - dropbox) feta en data:  $(date)" | mail -s "rclone (${carpeta_guardar}) finalment fet" -F user@localhost

exit 0;
