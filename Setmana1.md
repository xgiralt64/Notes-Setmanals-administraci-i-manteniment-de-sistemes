## Setmana sobre Arrencada del Sistema (Part 1)

### Resum teòric

Aquesta setmana hem treballat el procés d’**arrencada del sistema**, que és el conjunt de fases que permeten a un ordinador inicialitzar-se i carregar el sistema operatiu. Els punts principals són:

- **Fase 1: Maquinària**

  - La CPU col·loca el punter d’Instrucció (EIP) a la direcció de reset (0xFFFFFFF0) i fa un salt cap al firmware (BIOS/UEFI).
- **Fase 2: Firmware**

  - Funcions principals: provar, detectar, configurar i inicialitzar dispositius.
  - Etapes:
    1. Inicialització del firmware (lectura de NVRAM, verificació d’integritat).
    2. Diagnòstic i detecció (POST: comprovació de CPU, RAM, dispositius).
    3. Arrencada del sistema (selecció de dispositiu i càrrega del bootloader).
- **Actualització del firmware**

  - Objectius: corregir errades de microcodi, afegir suport a nou maquinari, millorar seguretat i energia.
  - Riscos: errors en el procés poden deixar el xip inservible (*brick*) si per exemple durant el procés se'n va la llum.
- **BIOS vs UEFI**

  - BIOS: emmagatzematge en ROM, limitat a discos de 2,2 TB, interfície en text, sense proteccions de seguretat.
  - UEFI: suporta discos grans (fins a 9,4 ZB), interfície gràfica, Secure Boot, modularitat i compatibilitat amb Legacy BIOS.
- **Taules de particions**

  - **MBR**: suporta fins a 4 particions primàries (o estesa + lògiques). Limitat a 2 TB.
  - **GPT**: suporta fins a 128 particions, headers primari i secundari, més segur i flexible.
- **UEFI i la partició EFI**

  - La UEFI funciona com un mini SO amb drivers i aplicacions.
  - Utilitza la partició EFI (ESP) amb sistema FAT32 per emmagatzemar fitxers d’arrencada.
  - El *boot manager* (efibootmgr en Linux) gestiona l’ordre i configuració d’arrencada.
- **Bootloaders**

  - De primera etapa: carregats directament pel firmware.
  - De segona etapa: carreguen el sistema operatiu.
  - Exemples: LILO (antic), GRUB/GRUB2, rEFInd, systemd-boot, Windows Boot Manager.

### Dubtes i preguntes

* Si per accident brickejem la nostra placa o xip del firmware, hi ha
  alguna manera fàcil de recuperar els continguts? O l'únic que podem fer
  és canviar el xip?
* És més segur utilitzar sempre GPT en lloc de MBR encara que utilitzem un disc amb poca capacitat?
