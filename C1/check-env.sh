#!/bin/bash
# Contrôles rapides avant / pendant le TP (ne lance rien).
set -u

ok() { printf "  [ok]  %s\n" "$1"; }
ko() { printf "  [!!]  %s\n" "$1"; }

echo "== Pré-requis TP1 =="

if command -v docker >/dev/null; then
  ok "docker $(docker --version | head -1)"
else
  ko "docker absent"
fi

if docker info >/dev/null 2>&1; then
  ok "daemon Docker joignable"
else
  ko "daemon Docker arrêté — ouvre Docker Desktop"
fi

if command -v java >/dev/null; then
  java -version 2>&1 | head -1 | sed 's/^/  [..]  /'
  echo "       Le PDF demande Java 11 Temurin (sdkman). Hadoop local aime 8/11, pas 25."
else
  ko "java absent"
fi

if command -v mvn >/dev/null; then
  ok "maven $(mvn -version 2>/dev/null | head -1)"
else
  ko "maven absent (nécessaire pour packager WordCount en local / jar)"
fi

if command -v mc >/dev/null; then
  ok "mc (MinIO Client) présent"
else
  ko "mc absent — https://min.io/docs/minio/linux/reference/minio-mc.html"
fi

command -v python3 >/dev/null && ok "python3 $(python3 --version)" || ko "python3 absent"
command -v gzip >/dev/null && ok "gzip présent" || ko "gzip absent"

echo
echo "== Fichiers de travail =="
for f in \
  TP1.md TP1-BigData.pdf CM1-BD.pdf \
  01-hdfs/docker-compose.yml \
  01-hdfs/hadoop_config/core-site.xml \
  01-hdfs/hadoop_config/hdfs-site.xml \
  01-hdfs/start-hdfs.sh \
  01-hdfs/init-datanode.sh
do
  if [[ -e $f ]]; then ok "$f"; else ko "$f manquant"; fi
done
