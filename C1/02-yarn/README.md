# Partie 2 — YARN + MapReduce

Ne pas copier ce dossier pour « finir » la partie 1 : le `docker-compose.yml`
du dépôt du cours contient déjà YARN.

Quand tu arrives à la partie 2 du PDF :

```bash
cd "$(dirname "$0")"
git clone https://github.com/Noobzik/big_data_ing3_cytech.git .
```

Tu y trouveras notamment :
- `docker-compose.yml` (NameNode, DataNode, ResourceManager, NodeManager)
- `hadoop_config/` (`core-site.xml`, `hdfs-site.xml`, `yarn-site.xml`)
- `mapreduce/` (WordCount : `TokenizerMapper`, `IntSumReducer`, `WordCount`)
- `start-yarn.sh`, `start-nodemanager.sh`
