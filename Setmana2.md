## Setmana sobre Arrencada del Sistema (Part 2)

### Resum teòric

Aquesta setmana hem aprofundit en la segona part del procés d’arrencada del sistema, centrant-nos sobretot en el GRUB, el kernel i l’initramfs.

- **GRUB/GRUB2**

  - És el gestor d’arrencada més habitual en sistemes Linux. La seva feina carregar el kernel i arrencar el sistema.
  - Permet escollir entre diversos sistemes operatius, passar paràmetres al kernel i fins i tot obrir una consola pròpia per resoldre problemes.
  - Té diverses etapes:
    - *Stage 1*: codi mínim al MBR (en BIOS) o fitxer EFI (en UEFI).
    - *Stage 1.5*: només en BIOS, per entendre sistemes de fitxers bàsics.
    - *Stage 2*: el menú complet de GRUB, amb mòduls extra i el pas final cap al kernel.
- **Configuració de GRUB**

  - El fitxer `grub.cfg` no es toca directament: es genera a partir de `/etc/default/grub` i els scripts de `/etc/grub.d/`.
  - Per aplicar canvis, fem `update-grub2` (Debian/Ubuntu) o `grub-mkconfig` (Arch/Fedora...).
  - Algunes variables interessants:
    - `GRUB_TIMEOUT`: temps d’espera abans de carregar l’entrada per defecte.
    - `GRUB_DEFAULT`: quin sistema o kernel arrencar per defecte.
    - `GRUB_CMDLINE_LINUX`: opcions que es passen al kernel (per exemple, `quiet`, `single`, `nomodeset`).
- **Secure Boot**

  - Una funcionalitat de la UEFI que comprova signatures digitals abans de carregar un bootloader.
  - En teoria garanteix seguretat, però també pot donar maldecaps amb Linux o kernels personalitzats. En el meu cas, el tinc desactivat ja que quan vaig instalar el sistema operatiu em va donar molts problemes amb les claus dels drivers.
  - Hi ha vulnerabilitats conegudes, i sovint s’acaba utilitzant un intermediari anomenat **Shim** perquè la UEFI accepti el GRUB.
- **El Kernel**

  - És el nucli del sistema operatiu i es carrega a la RAM en l’arrencada.
  - Necessita saber on és la partició arrel, i sovint s’ajuda d’un fitxer anomenat **initramfs** per poder començar.
- **Initramfs**

  - És com un mini sistema de fitxers a la RAM, carregat abans que el kernel pugui muntar el disc dur real.
  - Porta els controladors bàsics i scripts necessaris per trobar i muntar la partició arrel.
  - Etapes principals: descompressió a RAM, execució de l’script `/init`, muntatge de sistemes virtuals (/proc, /sys, /dev), càrrega de mòduls, muntatge de la partició arrel i finalment el pas al sistema complet (*switch_root*).
  - Es pot personalitzar i regenerar (`update-initramfs` a Debian/Ubuntu, `dracut` a Fedora/RedHat).

### Dubtes i preguntes

* És realment segur el *Secure Boot* o només ens complica la vida a usuaris de Linux?
* Per què cal utilitzar el Shim en lloc de carregar directament el GRUB amb Secure Boot?
