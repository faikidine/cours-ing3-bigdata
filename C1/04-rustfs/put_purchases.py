"""Partie 4 — même programme que Minio, autre endpoint si besoin.

RustFS est compatible S3 : le script de 03-minio/ doit presque se recoller ici.
"""

from pathlib import Path

FILE = Path(__file__).resolve().parents[1] / "01-hdfs" / "shared" / "purchases.txt"
BUCKET = "python"

# TODO : client S3 vers RustFS
# TODO : bucket + upload + vérif

raise NotImplementedError("À compléter pendant le TP")
