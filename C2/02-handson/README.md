# Partie 2 — HandsOn Scala

Ne pas copier ce dossier pour « finir » la partie 1 : le HandsOn est un
projet de tests à part (`__` et `???` à remplir).

Le dépôt est déjà cloné dans `scala-class/` (prépa : wifi / deps).
Ne remplis **pas** les tests avant d'être à la partie 2.

Le script `./handson` du repo pointe vers `$SBT_HOME/bin/sbt-launch.jar`
(souvent absent avec sbt Homebrew). Commande qui marche :

```bash
cd "$(dirname "$0")/scala-class"
sbt go
```

Équivalent PDF `handson go` si tu insistes :

```bash
chmod +x handson
./handson go   # probablement KO sans SBT_HOME
```

Tu y trouveras notamment :
- `build.sbt` (`scalaVersion` **2.13.18**, alias `go` = `~ testOnly HandsOnScala`)
- `src/test/scala/exercices/` (`e00_start.scala`, `e01_syntaxe.scala`, …)
- `getting_started.md`

Le PDF demande `src/test/scala/exercices/e00_scala_syntax.scala` :
ce fichier n'existe pas sous ce nom — commencer par `e00_start.scala`,
puis `e01_syntaxe.scala`.

IntelliJ : File > Open sur le `build.sbt` de `scala-class/`
(« Open as Project »), plugin **Scala** (déjà là). Le plugin
« Big Data Tools » n'est pas requis pour ce HandsOn.
