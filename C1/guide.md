# TP1 — Stack Hadoop (journal)

Consigne à lire en parallèle : `TP1-BigData.pdf` (ne pas la recopier ici).  
Cours : `CM1-BD.pdf` (J1-P2, écosystème Hadoop).

**Split Cursor :** `Cmd+\` puis glisser le PDF dans le volet de droite ; garder ce fichier à gauche.

---

## Carte CM1 → TP

| TP | Notion CM1 | À retenir avant de taper |
| --- | --- | --- |
| P1 HDFS | NameNode / DataNode / client ; fichiers **immuables** ; blocs + réplication ; CAP **CP** | On déplace le **traitement vers les données**, pas l’inverse |
| P2 YARN + MR | Map → Shuffle → Reduce ; ResourceManager, NodeManager, ApplicationMaster, Container | WordCount : map émet `(mot, 1)`, reduce somme |
| P3 Minio | Successeur logique HDFS = object storage type S3 | Compatible AWS S3 |
| P4 RustFS | CM1 : Minio à éviter, **RustFS à privilégier**, Ceph en cloud-native | Reproduire P3 |

---

## Pré-requis (coche au fur et à mesure)

État machine au moment de la prépa :

- [x] Docker CLI installé
- [ ] **Docker Desktop allumé** (daemon injoignable au setup)
- [ ] Java **11** Temurin — actuellement Homebrew **25** (ok dans les containers Hadoop ; gênant pour WordCount *local*)
- [ ] Maven (`mvn`) — absent, pour packager le jar P2
- [ ] CLI `mc` (MinIO Client) — absente, pour P3/P4
- [x] Python 3
- [x] macOS (pas besoin du guide Windows du PDF)

```bash
./check-env.sh
# Java 11 si besoin : https://sdkman.io/  →  sdk install java 11.0.x-tem
# Maven : brew install maven
```

Image Hadoop ~1,18 Go : éviter le Wi-Fi saturé de l’école.

---

## Partie 1 — HDFS

Dossier de travail : `01-hdfs/`

### Ex. 1 — Déployer NameNode + DataNode

Fichiers à **compléter** (squelettes déjà là) :

| Fichier | Rôle |
| --- | --- |
| `01-hdfs/docker-compose.yml` | 2 services + réseau `172.20.0.0/16` |
| `01-hdfs/start-hdfs.sh` | format NameNode si besoin + daemon |
| `01-hdfs/init-datanode.sh` | reset dataNode + daemon |
| `01-hdfs/hadoop_config/core-site.xml` | gist du cours, **à ajuster** |
| `01-hdfs/hadoop_config/hdfs-site.xml` | gist du cours, **à ajuster** |

Gist d’origine : https://gist.github.com/Noobzik/ddfc792c56ae11bcb9b546c0bd0fad3c

Le PDF dit « modifiez les valeurs suivantes » puis enchaîne sur les scripts : **la liste des champs n’est pas dans le PDF**. À croiser avec le CM1 et tes volumes :

- `fs.defaultFS` ↔ hostname du service NameNode + port RPC
- `hadoop.tmp.dir` / `dfs.namenode.name.dir` / `dfs.datanode.data.dir` ↔ chemins montés (`/opt/hadoop/data/...`)
- `dfs.replication` ↔ tu n’as **qu’un** DataNode

Pièges PDF :

- Nom du script : `start-hdfs.sh` (volumes) vs `start_hdfs.sh` (titre du PDF) → garder les **tirets**.
- `docker compose up` depuis `01-hdfs/`
- Erreur `Pool overlaps with other one` → changer `172.20` en `172.60` (compose **et** les `ipv4_address`)
- Toujours un chemin HDFS **absolu** (`/input`, pas `.`) sinon `ls: '.': No such file or directory`

```bash
cd 01-hdfs
docker compose up
# autre terminal :
docker exec -it namenode /bin/bash
```

UI NameNode : http://localhost:9870  
UI DataNode : http://localhost:9864

**Observations (après up) :**

- Logs compose / NameNode live ? …
- http://localhost:9870 : combien de Live Nodes ? …
- Config XML : quelles valeurs as-tu changées, et pourquoi ? …

### Aide-mémoire HDFS (dans le container namenode)

Toujours préfixer par `/` (racine HDFS).

| Intention | Commande (à adapter) |
| --- | --- |
| Lister | `hdfs dfs -ls /` |
| Créer un dossier | `hdfs dfs -mkdir -p /input` |
| Upload local → HDFS | `hdfs dfs -put … …` |
| Download HDFS → local | `hdfs dfs -get … …` |
| Queue du fichier | `hdfs dfs -tail …` |
| Tout le fichier | `hdfs dfs -cat …` |
| Renommer / déplacer | `hdfs dfs -mv … …` |
| Supprimer | `hdfs dfs -rm …` |

Le dossier hôte `01-hdfs/shared` est monté **dans** le container en `/shared`.

### Ex. 2 — Premières commandes

Prépa données (depuis `01-hdfs/shared`) — URL **raw**, pas la page GitHub Blob du PDF :

```bash
cd 01-hdfs/shared
curl -L -o purchases.txt.gz \
  "https://github.com/CodeMangler/udacity-hadoop-course/raw/ec6bbb839bdc6e701f802c523497fef4e1c206d0/Datasets/purchases.txt.gz"
gzip --decompress purchases.txt.gz
```

Le PDF mélange `purchase.txt` et `purchases.txt` : le fichier réel est **`purchases.txt`**.  
`file1.txt` est déjà dans `shared/` (utile plus tard pour Minio).

Dans le namenode :

```bash
hdfs dfs -mkdir -p /input
# TODO : copier /shared → /input
# TODO : lister /input
# TODO : tail de purchases.txt depuis HDFS
```

**Notes :**

- Sortie de `ls` / `tail` : …
- Où vois-tu le fichier dans l’UI 9870 (Utilities / Browse the file system) ? …

---

## Partie 2 — YARN et MapReduce

Dossier : `02-yarn/` (vide volontairement). **Éteins** d’abord le cluster P1 :

```bash
cd 01-hdfs && docker compose down
cd ../02-yarn
git clone https://github.com/Noobzik/big_data_ing3_cytech.git .
docker compose up
```

UI YARN : http://localhost:8088/cluster

### Section 1 — WordCount en local

Classes dans `02-yarn/mapreduce/src/main/java/fr/cytech/` :

- `TokenizerMapper` — map
- `IntSumReducer` — reduce
- `WordCount` — job (main)

Java 11 + Maven recommandés. Input = dossier contenant `purchases.txt` ; output = dossier **inexistant**.

```bash
# TODO : commande de lancement local (args input / output)
```

**Que remarques-tu à l’exécution ?**


**Contenu / forme de `part-r-00000` ?**


### Section 2 — Sur le cluster

Idée CM1 : le jar va **vers** les données (ResourceManager), pas l’inverse.

```bash
# 1. Maven package → jar with dependencies
# 2. docker cp … resourcemanager:/root/wc.jar
# 3. docker exec -it resourcemanager /bin/bash
yarn jar /root/wc.jar /user/root/input /user/root/output
# 4. hadoop fs -cat du part-r-00000
```

Le PDF attend en fin de fichier des comptes du type `Women's`, `Worth`, `York`, `and`.

**Différence local vs cluster ?**


---

## Partie 3 — Minio

Dossier **différent** : `03-minio/`  
Arrêter Hadoop/YARN pour libérer la RAM (et plus tard les ports 9000/9001 pour P4).

```bash
cd 03-minio
# TODO : compléter docker-compose.yml (bloc PDF)
docker compose up
```

CLI : https://min.io/docs/minio/linux/reference/minio-mc.html

Le PDF dit UI sur `localhost:9000`. Sur Minio actuel, **9000 = API S3**, **9001 = console**. Tester les deux.

```bash
# TODO : mc alias set …
# TODO : bucket `test`
# TODO : mc cp de file1.txt et purchases.txt à la racine du bucket
```

Python : `03-minio/put_purchases.py` (bucket `python`, API AWS/S3).

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
python put_purchases.py
```

**Notes (alias mc, buckets, vérif console) :**


---

## Partie 4 — RustFS

Reproduire P3 dans `04-rustfs/`. Stopper Minio avant (mêmes ports).

Docs : https://docs.rustfs.com/en/installation/container  
Image : https://hub.docker.com/r/rustfs/rustfs

`mc` et `boto3` restent valables (S3). Adapter l’endpoint / les clés.

**Ce qui change vs Minio :**


---

## Capture de commandes / erreurs

Colle ici les extraits utiles (pas tout le log Docker) :

```text

```
