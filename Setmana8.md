## Setmana sobre Virtualització i Contenidors

### Què és la virtualització?

La **virtualització** permet executar diversos sistemes operatius independents sobre una mateixa màquina física. Cada sistema virtual (VM) té:

* El seu propi sistema operatiu.
* Recursos assignats (CPU, RAM, disc).
* Aïllament fort respecte a les altres VMs.

Això fa possible, per exemple, tenir Linux i Windows funcionant alhora en un mateix servidor.

---

### Hipervisor

L’element clau de la virtualització és l’**hipervisor**, el programari que gestiona les màquines virtuals.

Tipus principals:

* **Tipus 1 (bare metal)**: s’executa directament sobre el maquinari.

  * Exemples: VMware ESXi, Xen, Hyper-V.
  * Més eficients i utilitzats en producció.
* **Tipus 2**: s’executa sobre un sistema operatiu host.

  * Exemples: VirtualBox, VMware Workstation.
  * Més habituals en entorns d’aprenentatge.

---

### Avantatges i inconvenients de les VMs

**Avantatges**:

* Aïllament molt fort.
* Sistemes completament independents.
* Bona seguretat.

**Inconvenients**:

* Més consum de recursos.
* Arrencada més lenta.
* Més pes en disc.

---

### Què són els contenidors?

Els **contenidors** són una forma de virtualització a nivell de sistema operatiu. En lloc de virtualitzar tot un sistema, els contenidors:

* Comparteixen el kernel de l’host.
* Aïllen processos, xarxa i sistema de fitxers.
* Són molt més lleugers que les VMs.

Un contenidor inclou només l’aplicació i les seves dependències, res més.

---

### Docker

**Docker** és la plataforma de contenidors més popular.

Conceptes bàsics:

* **Imatge**: plantilla immutable (com una recepta).
* **Contenidor**: instància en execució d’una imatge.
* **Dockerfile**: fitxer que defineix com es construeix una imatge.
* **Docker Hub**: repositori d’imatges.

Exemple simple:

```bash
docker run hello-world
```

---

### Arquitectura de Docker

Docker es basa en:

* **Docker Engine**: motor principal.
* **Namespaces**: aïllament de processos.
* **cgroups**: control de recursos (CPU, RAM).
* **UnionFS**: sistema de fitxers per capes.

Aquesta arquitectura explica per què els contenidors són tan ràpids i eficients.

---

### Orquestració de contenidors

Quan es treballa amb molts contenidors, cal una eina d’orquestració:

* **Kubernetes**: estàndard de facto.
* Gestiona escalat, fallades i desplegaments.
* Automatitza gran part de l’administració.

Tot i que és potent, també afegeix complexitat.

---

### Casos d’ús típics

* **VMs**:

  * Servidors normals.
  * Sistemes que necesitem que estiguin molt aillats.
* **Contenidors**:

  * Microserveis.
  * Desplegament ràpid d’aplicacions.
  * Entorns de desenvolupament.

---

### Reflexions finals

Les VMs aporten seguretat i compatibilitat, mentre que els contenidors ofereixen velocitat i flexibilitat.

Perque siguem uns bons administradors de sistemes hem de saber quan convé usar cada tecnologia, i entendre que, en molts entorns reals, conviuen totes dues.
