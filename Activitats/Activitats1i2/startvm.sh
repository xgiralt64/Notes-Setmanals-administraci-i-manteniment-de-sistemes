#!/bin/bash

DEBIAN_VM="Debian"
ALMALINUX_VM="AlmaLinux"

#Ports SSH
DEBIAN_PORT=2222
ALMALINUX_PORT=2223

echo "A quina màquina vols conectar-te?:"
echo "1) Debian"
echo "2) AlmaLinux"
read -p "(1/2): " choice

case $choice in
    1)
        echo "Iniciant Debian..."
        #Arrenco la VM en mode headless
        VBoxManage startvm "$DEBIAN_VM" --type headless
        echo "Esperant que Debian estigui disponible per SSH..."

        #Espero fins que SSH estigui disponible amb netcat
        until nc -z localhost $DEBIAN_PORT; do
            sleep 1
        done
        echo "Connectant via SSH a Debian..."
        ssh -p $DEBIAN_PORT -o IdentitiesOnly=yes xavier@localhost
        ;;
    2)
        echo "Iniciant AlmaLinux..."
        VBoxManage startvm "$ALMALINUX_VM" --type headless
        echo "Esperant que AlmaLinux estigui disponible per SSH..."

        until nc -z localhost $ALMALINUX_PORT; do
            sleep 1
        done
        echo "Connectant via SSH a AlmaLinux..."
        ssh -p $ALMALINUX_PORT -o IdentitiesOnly=yes xavier@localhost
        ;;
    *)
        echo "Has de triar 1 o 2"
        exit 1
        ;;
esac
