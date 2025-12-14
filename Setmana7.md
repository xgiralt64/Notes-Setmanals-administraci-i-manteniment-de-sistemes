## Setmana de Autenticació i Autorització (Part 1)

### Introducció

Aquesta setmana hem iniciat el bloc d’**Autenticació i Autorització**, un dels pilars de la seguretat en qualsevol sistema informàtic. Fins ara hem vist com s’arrenca el sistema i com s’organitzen les dades. Ara ens centrarem amb qui pot entrar al sistema i què pot fer un cop dins.

Encara que sovint es barregen, autenticació i autorització **no són el mateix**, i entendre bé la diferència és fonamental.

---

### Autenticació vs Autorització

* **Autenticació**: comprova **qui ets**.

  * Exemple: introduir usuari i contrasenya.
* **Autorització**: determina **què pots fer**.

  * Exemple: si pots llegir, modificar o executar un fitxer.

Un sistema pot autenticar correctament un usuari però denegar-li accions si no té permisos suficients.

---

### Identitat en sistemes Linux

En Linux, la identitat es basa principalment en:

* **UID (User ID)**: identificador numèric de l’usuari.
* **GID (Group ID)**: identificador del grup.
* **Usuaris**: comptes individuals.
* **Grups**: col·lectius d’usuaris amb permisos comuns.

Els identificadors numèrics són els que realment utilitza el sistema; els noms són només una representació amigable.

---

### Tipus d’usuaris

Linux diferencia diversos tipus d’usuaris:

* **root (UID 0)**: superusuari amb control total.
* **Usuaris del sistema**: utilitzats per serveis i dimonis.
* **Usuaris normals**: comptes humans.

Aquesta separació ajuda a limitar danys en cas de fallada o atac.

---

### Fitxers clau del sistema

La informació d’autenticació i comptes es guarda en diversos fitxers:

* `/etc/passwd` → informació bàsica dels usuaris.
* `/etc/shadow` → contrasenyes xifrades.
* `/etc/group` → definició de grups.
* `/etc/gshadow` → informació sensible de grups.

És important destacar que:

* `/etc/passwd` és llegible per tothom.
* `/etc/shadow` només és accessible per root.

---

### Contrasenyes i seguretat

Les contrasenyes **no s’emmagatzemen en text clar**, sinó mitjançant funcions de hash (SHA, yescrypt, etc.). Això evita que, encara que algú accedeixi al fitxer, no pugui llegir directament les contrasenyes.

### Procés de login

Quan un usuari inicia sessió:

1. Introdueix credencials.
2. El sistema comprova el hash.
3. Si és correcte, assigna UID, GID i entorn.
4. S’inicia la sessió de l’usuari.

---

### Gestió d’usuaris

Algunes ordres bàsiques d’administració:

```bash
useradd usuari
usermod -aG grup usuari
passwd usuari
userdel usuari
```

Aquestes comandes permeten crear, modificar i eliminar comptes de forma controlada.

---

### Autorització i permisos

Un cop autenticat, l’usuari està subjecte al sistema de permisos:

* Permisos sobre fitxers i directoris.
* Permisos heretats a través de grups.
* Restriccions específiques per serveis.

Aquí es connecta directament amb el que ja vam veure al tema de sistemes de fitxers.

---

### Reflexions finals

Tenir usuaris separats, permisos ben definits i contrasenyes segures redueix molt el risc d’incidents.

Entendre bé autenticació i autorització és imprescindible per administrar sistemes multiusuari de manera segura.
