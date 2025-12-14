## Setmana sobre Sistema de Fitxers (Part 2)

### Introducció

Aquesta setmana hem aprofundit en el concepte de **RAID**, una tecnologia clau quan es parla d’emmagatzematge en servidors i sistemes crítics. El RAID no només serveix per tenir més espai o més velocitat, sinó sobretot per **garantir continuïtat del servei** quan fallen discos.

Una idea important que queda clara des del principi és que **RAID no és una còpia de seguretat**. Ajuda a tolerar fallades, però no ens salva d’errors humans, corrupció de dades o atacs.

---

### Què és un RAID?

Un **RAID (Redundant Array of Independent Disks)** combina diversos discos físics per formar un únic sistema d’emmagatzematge lògic. Aquest sistema permet millorar:

* **Redundància**: continuar funcionant quan un disc falla.
* **Rendiment**: llegir i escriure dades més ràpidament.
* **Capacitat**: aprofitar millor l’espai disponible.

Aquests objectius s’aconsegueixen mitjançant tècniques com el **mirroring**, l’**striping** i la **paritat**.

---

### Conceptes clau

* **Redundància**: nombre de discos que poden fallar sense perdre dades.
* **Rendiment**: mesurat en IOPS i MB/s. depèn del nombre de discos, mida de stripe i tipus d’accés.
* **Stripe**: conjunt de blocs distribuïts entre els discos del RAID.
* **Bloc**: unitat mínima de lectura/escriptura.

---

### Tipus d’implementació de RAID

* **Software RAID**: gestionat pel sistema operatiu.

  * Flexible i independent del maquinari.
  * Utilitza CPU per calcular paritat.
* **Hardware RAID**: controladora dedicada.

  * Bon rendiment en certs escenaris.
  * Dependència del fabricant.
* **Fake/BIOS RAID**: solució híbrida.

  * Pot causar problemes de compatibilitat.

---

### Nivells de RAID principals

* **RAID 0 (Striping)**

  * Molt ràpid, però sense cap redundància.
  * Qualsevol fallada implica pèrdua total.
* **RAID 1 (Mirror)**

  * Duplicació exacta de dades.
  * Ideal per a sistemes crítics (com `/`).
* **RAID 5**

  * Paritat distribuïda.
  * Tolerància a 1 disc.
  * Bona lectura, escriptura penalitzada.
* **RAID 6**

  * Doble paritat.
  * Tolerància a 2 discs.
  * Més segur però més lent en escriptura.
* **RAID 10**

  * Combina mirroring i striping.
  * Excel·lent rendiment i redundància.
  * Costós en nombre de discos.

---

### RAID a Linux

Linux implementa RAID software mitjançant el subsistema **MD (Multiple Device)**, amb dispositius `/dev/mdX`.

Components importants:

* `md_mod`: gestor principal.
* `mdadm`: eina d’usuari per crear i gestionar RAIDs.
* `/proc/mdstat`: estat del RAID.
* `/sys/block/mdX`: informació detallada.

---

### Gestió amb mdadm

Algunes operacions habituals:

* Crear un RAID:

```bash
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda /dev/sdb
```

* Consultar l’estat:

```bash
mdadm --detail /dev/md0
cat /proc/mdstat
```

* Afegir o eliminar discos, simular fallades, reconstruir arrays… tot es fa amb `mdadm --manage`.

---

### RAID i l’arrencada del sistema

En sistemes amb RAID, l’**initramfs** inclou les eines necessàries per detectar i muntar els arrays abans d’arrencar el sistema. La comanda clau és:

```bash
mdadm --assemble --scan
```

Això garanteix que el sistema pugui arrencar fins i tot si un disc ha fallat (per exemple en RAID 1).

---

### Casos pràctics

* **Sistema root** → RAID 1 o RAID 10.
* **Emmagatzematge temporal i rendiment** → RAID 0.
* **Servidor de bases de dades** → RAID 10.

Cada cas té prioritats diferents: velocitat, seguretat o cost.

---

### Reflexions finals

Configurar un RAID és fàcil, però administrar-lo bé és el que marca la diferència. Cal provar fallades, assegurar que el sistema arrenca i entendre realment què passa quan un disc mor. En el meu cas personal disposo de una RAID de 12 discs de 1TB en RAID-Z2 que faig servir de NAS per guardar tots els meus fitxers. 

El RAID ajuda a mantenir el servei, però només una bona administració (i còpies de seguretat!) garanteix la seguretat de les dades.
