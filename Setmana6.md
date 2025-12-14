## Setmana sobre Sistema de fitxers (Part 3)

### Introducció

Aquesta setmana hem treballat el **LVM (Logical Volume Manager)**, una eina fonamental en administració de sistemes Linux quan es vol flexibilitat real en la gestió de l’emmagatzematge. El punt clau del tema és entendre que LVM resol un problema molt habitual: les **particions fixes** que s’omplen mentre d’altres tenen espai lliure.

Amb LVM, el disc deixa de ser rígid i passa a ser **dinàmic**, permetent ampliar, reduir o reorganitzar volums sense aturar el sistema ni moure dades manualment.

---

### Per què necessitem LVM?

En un sistema tradicional amb particions, si `/home` s’omple però `/var` o `/tmp` tenen espai lliure, la solució és complexa i arriscada ja que hem de moure totes les nostres dades per poder redimensionar una partició. LVM permet:

* Redimensionar volums **en calent**.
* Afegir nous discos sense reinstal·lar el sistema.
* Reorganitzar l’espai segons les necessitats reals.

Tot això amb el sistema en funcionament.

---

### Conceptes bàsics de LVM

LVM es basa en tres components principals:

* **PV (Physical Volume)**: dispositiu físic (disc, partició, RAID…).
* **VG (Volume Group)**: agrupació de PVs.
* **LV (Logical Volume)**: volum lògic on es crea el sistema de fitxers.

---

### Extents i mapatge

LVM divideix l’espai en blocs petits:

* **PE (Physical Extent)**: unitat mínima d’un PV (normalment 4 MB).
* **LE (Logical Extent)**: unitat mínima d’un LV.

Els PE i LE tenen la mateixa mida, i el VG s’encarrega de mapar els blocs físics amb els lògics. Aquesta abstracció és el que permet moure i redimensionar volums sense que el sistema de fitxers ho noti.

---

### Característiques principals de LVM

* **Elasticitat**: ampliar o reduir volums segons necessitat.
* **Escalabilitat**: afegir o treure discos fàcilment.
* **Aprovisionament**: combinar discos de diferents mides.
* **Resiliència**: suport per snapshots i mirroring.

Aquestes característiques fan que LVM sigui molt habitual en servidors.

---

### Snapshots

Els **snapshots** són còpies instantànies d’un LV en un moment concret. Funcionen de manera incremental: només ocupen espai pels blocs que canvien.

Són especialment útils per:

* Fer còpies de seguretat sense aturar serveis.
* Provar canvis i poder tornar enrere.
* Recuperar dades després d’un error.

---

### LVM a Linux

A Linux, LVM es gestiona amb el paquet **lvm2**, present a la majoria de distribucions.

Eines principals:

* `pv*` → gestió de Physical Volumes
* `vg*` → gestió de Volume Groups
* `lv*` → gestió de Logical Volumes

La sintaxi és molt coherent i facilita l’administració.

---

### Operacions habituals

* Crear un PV:

```bash
pvcreate /dev/sdb
```

* Crear un VG:

```bash
vgcreate datavg /dev/sdb
```

* Crear un LV:

```bash
lvcreate -L 5G -n home datavg
```

* Ampliar un LV en calent:

```bash
lvextend -L 7G /dev/datavg/home
resize2fs /dev/datavg/home
```

---

### LVM i l’arrencada del sistema

No és recomanable utilitzar LVM per a `/boot` o `/boot/efi`, ja que els bootloaders com **GRUB** no poden llegir directament sistemes de fitxers LVM. Per això, aquestes particions es deixen sempre com a particions tradicionals.

### Reflexions finals

LVM és una eina molt potent que simplifica enormement la gestió de discos. No substitueix les còpies de seguretat i pot generar problemes si no es controla l’ús de l’espai.

Quan l'utilitzwm correctament, LVM permet que els sistemes creixin i s’adaptin sense interrupcions, que és un dels objectius principals de qualsevol administrador de sistemes.
