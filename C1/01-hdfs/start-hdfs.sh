#!/bin/bash
set -euo pipefail

# Script lancé au démarrage du container namenode.
# Le PDF l'appelle aussi start_hdfs.sh : le volume Docker attend start-hdfs.sh (tirets).
#
# À compléter (PDF Partie 1, création des fichiers) :
# 1. Si le NameNode n'est pas encore formaté (pas de dossier `current` sous data/nameNode),
#    le formater en mode non interactif.
# 2. Démarrer le daemon NameNode.

echo "TODO: formatter si besoin, puis lancer hdfs namenode"
exit 1
