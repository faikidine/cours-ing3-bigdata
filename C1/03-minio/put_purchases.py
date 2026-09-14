"""Partie 3, exercice 2 — déposer purchases.txt dans un bucket `python`.

Minio parle le protocole S3 : tu peux utiliser boto3 (API AWS) ou le SDK minio.
Endpoint local, identifiants = ceux du docker-compose.

À lancer depuis 03-minio/ une fois le serveur up, avec le fichier
../01-hdfs/shared/purchases.txt disponible.
"""

from pathlib import Path

FILE = Path(__file__).resolve().parents[1] / "01-hdfs" / "shared" / "purchases.txt"
BUCKET = "python"

# TODO : client S3 (endpoint, access key, secret, éventuellement region / path-style)
# TODO : créer le bucket s'il n'existe pas
# TODO : upload de FILE sous un nom d'objet au choix
# TODO : vérifier (list_objects / head_object)

raise NotImplementedError("À compléter pendant le TP")
