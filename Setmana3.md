## Setmana sobre Arrencada del Sistema (Part 3)

### Resum general

Aquesta setmana hem acabat l'estudi de la fase d'inicialització del sistema i hem iniciat l'anàlisi de la etapa central del procés: el punt en què el control es transfereix des del nucli (kernel) cap a l'espai d'usuari. Fins al moment, havíem fet les fases anteriors de l'arrencada (GRUB, càrrega del kernel, initramfs...) a partir d'ara, ens trobem dins de l'entorn del sistema operatiu.

### PID 1: El primer procés

Quan el kernel acaba la seva feina i transfereix el control a l’espai d’usuari, el primer procés que s’executa és el **PID 1**. Aquest procés és l’arrel de tots els altres processos del sistema.

Abans es feia servir el vell init, però avui dia gairebé totes les distribucions utilitzen **systemd**.
Aquest carrega serveis, gestiona processos, controla l’apagat, i fins i tot recull logs.

Funcions principals:

- Carregar els serveis i dimonis necessaris.
- Gestionar processos orfes.
- Ser el punt d’arrel de l’arbre de processos.
- Gestionar l’apagat i reinici del sistema.

### Systemd vs SysVinit

Aquest és un dels punts més polèmics del món Linux. SysVinit era simple i lineal: scripts seqüencials que s’executaven un després de l’altre.
Systemd va ser creat per millorar rendiment i control: arrenca serveis en paral·lel, gestiona dependències i fa servir *cgroups* per limitar recursos.

**Avantatges de systemd:**

- Més ràpid (inici en paral·lel).
- Més modular.
- Seguiment i control granular dels serveis (journalctl, dependències...).

**Crítiques:**

- Massa complex.
- Contradiu la filosofia Unix (“fes una sola cosa i fes-la bé”).
- Dependències excessives: moltes eines modernes depenen de systemd.

Aquest debat continua obert: hi ha qui el veu com una evolució necessària i qui el considera massa intrusiu.

### El cas XZ Utils

Un dels punts més interessants (i alarmants) de la setmana ha estat l’estudi del backdoor de XZ Utils (CVE-2024-3094).
Aquest incident real mostra com una vulnerabilitat en una llibreria aparentment inofensiva pot posar en perill tot un ecosistema.

Resum del cas:

- Un suposat col·laborador legítim va introduir canvis maliciosos a la llibreria xz-utils.
- Aquests canvis permetien executar codi maliciós a través de systemd i OpenSSH.
- Va afectar servidors Linux arreu del món abans que fos detectat.

Aquest cas il·lustra com la complexitat i interdependència dels sistemes actuals (especialment amb systemd) pot amplificar riscos.

### Targets i runlevels

Systemd organitza l’estat del sistema en **targets**, que són com punts de referència o modes d’execució.Cada target agrupa un conjunt de serveis. Alguns dels més importants són:

- `default.target`: El punt d’entrada per defecte (normalment enllaçat a `graphical.target` o `multi-user.target`).
- `graphical.target`: Entorn gràfic complet.
- `multi-user.target`: Mode text amb múltiples usuaris (com els servidors).
- `rescue.target` i `emergency.target`: Modes de recuperació.
- `reboot.target` i `shutdown.target`: Reinici o apagat.

Es poden canviar amb:

```bash
systemctl isolate <target>
systemctl set-default <target>
```

### Units i tipus d’unitats

Systemd funciona a través de unitats (`units`), que són fitxers de configuració per cada servei o component.

Ubicacions principals:

* `/etc/systemd/system/` → Configuracions creades per l’usuari.
* `/run/systemd/system/` → Configuració temporal per a la sessió actual.
* `/usr/lib/systemd/system/` → Fitxers de la distribució.

Tipus de unitats:

* **service** : defineix un servei (ex: `sshd.service`).
* **socket** : gestiona connexions.
* **mount** : punts de muntatge.
* **timer** : tasques programades.
* **target** : agrupa altres unitats.

Algunes opcions comunes de systemd:

* `ExecStart` / `ExecStop`: comandes d’inici i aturada.
* `Restart`: reiniciar automàticament en cas de fallada.
* `User` / `Group`: usuari i grup d’execució.
* `Environment`: variables d’entorn.
* `TimeoutStartSec`: temps d’espera per iniciar.

### Aprenentatge

Aquesta setmana ha estat especialment interessant perquè tanca el cicle complet d’arrencada del sistema, des del firmware fins a l’entorn d’usuari.

M’ha cridat l’atenció com tot està tan connectat: un petit error en un servei o una dependència mal definida pot impedir que el sistema s’aixequi.

També m’ha fet veure que systemd és una eina potent però amb molt poder... i riscos associats . El cas de XZ Utils n’és una prova real.
