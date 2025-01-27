# Scripts crontab

Aquest repositori conté alguns scripts en bash que m'han servit i/o encara em serveixen per automatitzar processos.

## Scripts

### 1. Backup Script

Aquest script realitza una còpia de seguretat d'una carpeta especificada, la comprimeix, l'encripta i la carrega a una destinació remota mitjançant `rclone`.

**Principals funcionalitats:**
- Estalvi d'espai mitjançant la compressió de la carpeta origen en un fitxer temporal.
- Encriptar el fitxer temporal.
- Signar el fitxer encriptat amb `gpg2` per a posteriorment poder verificar que no hagi sigut alterat, ni en trànsit ni en destinació.
- Carregar el fitxer encriptat i signat a una destinació remota (com Dropbox) utilitzant `rclone`.
- Enviar un correu electrònic de notificació al servidor de correu local un cop la còpia de seguretat s'ha completat.

### 2. Cleanup Script

Aquest script neteja fitxers antics d'una destinació remota mantenint un màxim de 4 fitxers en aquesta destinació.

**Principals funcionalitats:**
- Comprovar la quantitat de fitxers a la destinació remota.
- Eliminar els fitxers més antics fins a mantenir-ne només 4 (Dos que contenen les dades i 2 que contenen els fitxers de verificació).
- Enviar un correu electrònic de notificació al correu local un cop la neteja s'ha completat.

## Requisits

- **gnupg-utils**: Per encriptar/signar fitxers.
- **rclone**: Per copiar i eliminar fitxers de la destinació remota.
- **mail**: Per enviar notificacions per correu electrònic.

## Ús

1. **Backup Script**: Executar l'script amb els permisos adequats.
2. **Cleanup Script**: Executar l'script amb els permisos adequats.

### Exemples

```bash
./backup_script.sh
./cleanup_script.sh
```
