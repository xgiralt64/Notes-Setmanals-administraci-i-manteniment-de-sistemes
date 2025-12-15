## Setmana sobre Autenticació i Autorització (Part 2) – PAM

### Introducció

Aquesta setmana hem aprofundit en **PAM (Pluggable Authentication Modules)**, una de les peces més importants de la seguretat en sistemes Linux. PAM és el mecanisme que permet **centralitzar i unificar l’autenticació i la gestió de sessions** per a tots els serveis del sistema.

**Les aplicacions no gestionen directament l’autenticació**, sinó que deleguen aquesta responsabilitat a PAM. Això facilita el manteniment, millora la seguretat i permet afegir nous mètodes d’autenticació sense tocar el codi dels programes.

---

### Per què PAM és necessari?

En sistemes moderns hi ha molts serveis que necessiten autenticació: `login`, `sshd`, `sudo`, serveis gràfics, etc. Sense PAM:

* Cada aplicació hauria d’implementar la seva pròpia autenticació.
* Les polítiques de seguretat serien inconsistents.
* El manteniment seria molt més complex.

PAM resol això oferint un **framework modular i reutilitzable**, on totes les aplicacions fan servir la mateixa interfície.

---

### Què és PAM?

PAM és un **framework d’autenticació modular** utilitzat en sistemes Unix/Linux que permet integrar diferents mètodes d’autenticació:

* Contrasenyes locals (Unix)
* LDAP
* Kerberos
* Biometria
* Targetes intel·ligents
* 2FA

Els administradors poden canviar o afegir mòduls sense modificar les aplicacions.

---

### Esquema de funcionament

El flux general és:

1. L’usuari intenta accedir a un servei (SSH, login, sudo…).
2. El servei crida la llibreria **libpam**.
3. PAM consulta el fitxer de configuració corresponent a `/etc/pam.d/`.
4. S’executen els mòduls configurats.
5. PAM retorna si l’accés és permès o denegat.

Cada servei té el seu propi fitxer de configuració PAM.

---

### Tipus de mòduls PAM

Cada mòdul PAM té un rol específic dins del procés:

* **auth** → verifica la identitat de l’usuari.
* **account** → comprova si l’usuari pot accedir (horaris, bloquejos…).
* **password** → gestiona el canvi de contrasenyes.
* **session** → gestiona l’inici i el tancament de sessions.

Aquests tipus s’executen sempre en l’ordre:

`auth → account → password → session`

---

### Stack de mòduls PAM

Els mòduls s’organitzen en **stacks**, és a dir, piles de mòduls que s’executen en ordre. Cada servei té quatre stacks (un per tipus).

L’ordre és important:

* Els mòduls s’executen de dalt a baix.
* El resultat final depèn tant de l’ordre com de les **flags**.

---

### Flags dels mòduls

Les flags determinen com afecta cada mòdul al resultat global:

* **required**: ha de passar; si falla, l’autenticació acabarà fallant.
* **requisite**: ha de passar; si falla, es talla immediatament.
* **sufficient**: si passa, s’omet la resta del stack.
* **optional**: no és crític, només afegeix funcionalitat.
* **include / substack**: permet reutilitzar configuracions comunes.

Aquest sistema dona molta flexibilitat, però també pot ser perillós si es configura malament.

---

### Mòduls PAM habituals

Alguns dels mòduls més utilitzats són:

* `pam_unix.so` → autenticació clàssica Unix.
* `pam_ldap.so` → autenticació amb LDAP.
* `pam_krb5.so` → Kerberos.
* `pam_cracklib.so` → validació de contrasenyes fortes.
* `pam_limits.so` → límits de recursos.
* `pam_tally2.so` → control d’intents fallits.
* `pam_mkhomedir.so` → crea el directori home automàticament.

---

### Fitxers de configuració PAM

Els fitxers de PAM es troben a:

* `/etc/pam.d/`

Cada servei té el seu fitxer (`sshd`, `login`, `sudo`, etc.). A més, existeixen fitxers comuns:

* `common-auth`
* `common-account`
* `common-password`
* `common-session`

Aquests es poden incloure amb `include` per evitar duplicació.

---

### Estructura d’una línia PAM

Cada línia segueix aquest format:

```
<tipus> <flag> <mòdul> [opcions]
```

Exemple:

```
auth required pam_unix.so try_first_pass
```

---

### Opcions habituals

Algunes opcions freqüents:

* `nullok` → permet usuaris sense contrasenya.
* `try_first_pass` → reutilitza la contrasenya ja introduïda.
* `use_first_pass` → no demana una nova contrasenya.
* `minlen`, `difok` → polítiques de contrasenyes.
* `sha512` → tipus de xifrat.

---

### Depuració i logs

Quan alguna cosa falla amb PAM, els logs són essencials:

* `/var/log/auth.log` (Debian/Ubuntu)
* `/var/log/secure` (Red Hat)
* `/var/log/syslog`

També es pot activar el mode `debug` als mòduls o executar serveis amb més verbositat (`ssh -vvv`).

---

### Bones pràctiques amb PAM

* Fer còpies de seguretat abans de tocar PAM.
* Provar sempre amb una sessió oberta.
* Ser molt curós amb `sufficient`.
* Aplicar polítiques estrictes per serveis crítics.
* Mantenir el sistema actualitzat.

Un error a PAM pot **bloquejar completament l’accés al sistema**.

---

### Reflexions finals

Aquest tema deixa clar que PAM és molt potent, però també perillós si no s’entén bé. Centralitza tota l’autenticació del sistema, així que qualsevol canvi té impacte global.
