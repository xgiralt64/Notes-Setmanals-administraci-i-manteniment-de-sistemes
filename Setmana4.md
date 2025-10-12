## Setmana sobre Sistema de Fitxers (Part 1)

### Introducció

Aquesta setmana hem començat un nou bloc dedicat al sistema de fitxers. Després de veure com el sistema operatiu s’arrenca i es posa en marxa, ara ens hem centrat en com aquest organitza, emmagatzema i gestiona les dades dins dels dispositius d’emmagatzematge.

Al principi m'ha semblat un tema molt tècnic pero és fonamental per entendre com funciona un sistema des de dins: com s’escriu un arxiu, com es troba dins del disc, i què passa quan s’esborra.

### Què és un sistema de fitxers

Un sistema de fitxers és el conjunt d’estructures i regles que permeten al sistema operatiu guardar i recuperar dades d’un dispositiu d’emmagatzematge (com un disc dur o una memòria USB).
És com un gran mapa que diu on està tot i com s’hi pot accedir.

Els seus objectius principals són:

- Assignar espai d’emmagatzematge als fitxers.
- Gestionar directoris i permisos.
- Controlar la lectura i escriptura.
- Garantir la integritat i seguretat de les dades.

### Components bàsics

1. **Superbloc**
   Conté la informació general sobre el sistema de fitxers: el tipus, la mida, el nombre de blocs, i l’estat global. Si es corromp, el sistema pot quedar inusable.
2. **Inodes (index nodes)**
   Cada fitxer té un inode associat. Conté metadades com permisos, propietari, data de modificació i la ubicació dels blocs que contenen les dades del fitxer.
3. **Blocs de dades**
   Són les unitats mínimes d’emmagatzematge. Cada bloc pot contenir part d’un fitxer o estar lliure. El sistema en controla l’assignació.
4. **Taules d’inodes i de blocs lliures**
   Serveixen per saber quins inodes i blocs estan ocupats o disponibles.
5. **Directoris**
   No són més que fitxers especials que contenen la correspondència entre noms de fitxers i els seus inodes.

### Jerarquia de directoris

En Linux, tot està organitzat sota un únic arbre de directoris, que comença a la **arrel /**.
No hi ha discs C o D com a Windows — tot s’uneix dins d’una sola jerarquia.

Alguns directoris importants:

- `/` → arrel del sistema.
- `/bin`, `/sbin` → programes essencials.
- `/etc` → fitxers de configuració.
- `/home` → carpetes d’usuari.
- `/var` → dades variables (logs, correu, etc.).
- `/tmp` → fitxers temporals.
- `/mnt`, `/media` → punts de muntatge.

### Tipus de sistemes de fitxers

N’hi ha molts, cadascun amb avantatges i limitacions segons l’ús:

- **ext2 / ext3 / ext4** → Els més típics a Linux. Ext4 és el més modern i fiable.
- **XFS** → Molt eficient per a grans volums de dades i servidors.
- **Btrfs** → Suporta snapshots, compressió i gestió avançada.
- **FAT32 / exFAT / NTFS** → Formats habituals en sistemes Windows.
- **ZFS** → Extremadament robust, amb autocorrecció i gestió de volums integrada.

### Muntatge i punts de muntatge

Perquè el sistema pugui accedir a un dispositiu, cal **muntar-lo** dins de la jerarquia de directoris.
El **punt de muntatge** és el lloc on s’integra el contingut del dispositiu.

Exemple:

```bash
sudo mount /dev/sdb1 /mnt/usb
```

Aquí, el contingut del dispositiu `/dev/sdb1` apareix dins de `/mnt/usb`.

També es pot definir al fitxer `/etc/fstab`, que indica quins dispositius es munten automàticament a l’inici.

### Permisos i propietats

Linux utilitza un sistema de permisos molt estructurat. Cada fitxer té tres tipus de permisos:

**r**   lectura
**w**   escriptura
**x**   execució

I aquests permisos s’apliquen a tres categories:

* **Usuari (u)** → el propietari del fitxer.
* **Grup (g)** → altres usuaris del mateix grup.
* **Altres (o)** → tots els altres usuaris.

Es poden veure amb `ls -l` i modificar amb `chmod`, `chown` o `chgrp`.

### Fragmentació i rendiment

Amb el temps, els fitxers poden quedar fragmentats (repartits en blocs no contigus), cosa que pot alentir la lectura.

Els sistemes de fitxers moderns, com ext4 o XFS, gestionen això automàticament i redueixen molt el problema.

### Dubtes i preguntes

* Què passa exactament quan el superbloc es corromp? És possible recuperar el sistema?
* Btrfs i ZFS són realment adequats per a ús normal o massa complexos?

### Reflexions personals

Aquesta setmana m’ha sorprès com Linux manté tot el sistema unificat sota un sol arbre de directoris, fent que qualsevol dispositiu sembli part del mateix sistema.

El tema dels permisos m’ha semblat especialment important, ja que és clau per la seguretat i l’ordre dins d’un sistema amb diversos usuaris.
