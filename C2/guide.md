# TP2 — Scala (journal)

Consigne à lire en parallèle : `TP2-BigData.pdf` (ne pas la recopier ici).  
Cours : `CM2-BD-Scala.pdf` (J2, langage Scala).  
Tuto officiel dont le CM est tiré : https://docs.scala-lang.org/tutorials/scala-for-java-programmers.html

**Split Cursor :** `Cmd+\` puis glisser le PDF dans le volet de droite ; garder ce fichier à gauche.

---

## Carte CM2 → TP

| TP | Notion CM2 | À retenir avant de taper |
| --- | --- | --- |
| Ex1 Hello + sbt | `object` + `extends App` vs `def main` ; `Unit` = void ; SBT | Scala **2.13.15** (pas 3.x : Spark/Kafka n'ont pas migré) |
| Ex1 FrenchData | Interop Java (`java.time`) ; import `{A, B}` et `._` | `val` immuable, `var` mutable — on privilégie `val` |
| Ex2 Timer | Méthode (`def`) vs fonction (`val`) ; `() => Unit` ; anon. | Pas d'interface fonctionnelle à créer, contrairement à Java |
| Ex3–4 Complex | Classe / constructeur dans le nom ; `override def` | Héritage de `scala.AnyRef` (pas `java.lang.Object`) |
| Ex5 Calc | `case class` = record ; `match` / `sealed` | Data engineer : pattern matching dans les pipelines |
| Ex6 Ord / Date | Trait = interface **avec du code** | Implémenter `<` + `equals`, le reste se déduit |
| HandsOn | HoF (`map`), MPL / curry / `foldLeft` | Les `test` du dépôt ; pas un `main` |

---

## Pré-requis (coche au fur et à mesure)

État machine au moment de la prépa :

- [x] **sbt** 1.12.8 (Homebrew) — le PDF demande « la dernière version via sdkman »
- [x] **Java** — Homebrew **25** (le dépôt HandsOn a été upgradé pour Java 25)
- [x] **openjdk@17** aussi installé (secours si 2.13.15 râle sur le 25)
- [ ] **sdkman** — absent (le PDF le recommande ; pas bloquant si sbt + JDK sont là)
- [ ] **Scala CLI 2.13.x** — le `scala` du PATH est un wrapper Coursier vers **Scala 3.8.3** dont le cache est cassé. `sbt run` n'en a pas besoin (sbt télécharge 2.13 tout seul). Le bullet `scalac` / `scala` de l'Ex1, si : `cs install --force scala:2.13.15`
- [x] **git**
- [x] **IntelliJ IDEA** + plugin **Scala**
- [ ] Plugin **Big Data Tools** — non installé. Inutile pour ce TP (syntaxe Scala, pas Spark)
- [x] macOS (ignorer le guide Windows du PDF)

```bash
./check-env.sh
# Scala 2.13 CLI (optionnel, Ex1 scalac) :
#   cs install --force scala:2.13.15
```

Premier `sbt run` : téléchargement du compilateur 2.13 + deps. Éviter le Wi-Fi saturé de l'école — lance un `sbt run` **chez toi** dès que `build.sbt` est valide, même si Hello n'affiche encore rien.

---

## Partie 1 — Prise en main

Dossier de travail : `01-hello/`  
Le PDF dit `mkdir hello` : ici le dossier est déjà créé (arborescence sbt du CM2) pour que tu n'aies plus qu'à **compléter** les fichiers.

| Fichier | Rôle |
| --- | --- |
| `01-hello/build.sbt` | `name` / `version` / `scalaVersion` (PDF) |
| `src/main/scala/garden/bots/Hello.scala` | Ex1 Hello World |
| `src/main/scala/FrenchData.scala` | Ex1 date FR |
| `src/main/scala/Timer.scala` | Ex2 |
| `src/main/scala/Complex.scala` | Ex3 + Ex4 |
| `src/main/scala/Tree.scala` + `Calc.scala` | Ex5 |
| `src/main/scala/Ord.scala` + `Date.scala` | Ex6 |

Tout est dans **un** projet sbt : dès qu'il y a plusieurs `main`, sbt demande lequel (CM2, commandes SBT).

`Date.scala` étend `Ord` : le `<` de l'énoncé est déjà dans le squelette pour que `sbt run` compile dès l'Ex1. `equals` et les 3 méthodes de `Ord` restent à toi.

### Ex. 1 — Hello + SBT

Fichiers à **compléter** (squelettes déjà là).

```bash
cd 01-hello
# TODO : remplir build.sbt (3 lignes du PDF)
sbt run
# Tips PDF / CM2 : `sbt` une fois, puis `run` dans le prompt
```

Pièges PDF :

- Prérequis : Scala **2.12.15** via sdkman. `build.sbt` **et** CM2 : **2.13.15**. Prendre **2.13.15** (raison CM2 : écosystème Apache).
- « `build.sbt` au même endroit que le dossier Hello » : non, **dans** le projet (`01-hello/build.sbt`), comme le schéma CM2.
- `Hello.Scala` (PDF) vs `Hello.scala` — casse Linux/macOS.
- `package garden.bots` : `scala Hello` du PDF ne marche pas. Depuis le dossier du `.scala` : `scala garden.bots.Hello`, ou `sbt run`.
- Point-virgule → « tu es en JavaScript » : blague. Scala les accepte ; le cours s'en passe.
- `LocalDate` n'est **pas** dans `java.lang` (PDF) → `java.time.LocalDate` (CM2).
- `withLocal(FRANCE)` (PDF) → `withLocale` (CM2 utilise `KOREA` ; ici `FRANCE` via `Locale._`).
- Remarque PDF `java.util.Local._` → `Locale._`.

Passage compilateur « nu » (après `sbt run`, pour voir la différence) :

```bash
cd src/main/scala/garden/bots
# TODO : scalac Hello.scala && scala …
```

**Observations :**

- Premier `sbt run` : qu'est-ce qui se télécharge, combien de temps ? …
- Sortie Hello World : …
- Après `def main` : même comportement ? …
- FrenchData : quelle chaîne de date (langue / format) ? …


---

### Ex. 2 — Timer (fonctions d'objet)

`01-hello/src/main/scala/Timer.scala`

Signature donnée dans le PDF : `callback: () => Unit`.  
`()` = fonction sans argument, `=>` annonce le type de retour.

```bash
# dans le prompt sbt :
run
# choisir Timer
```

Boucle `while (true)` + `Thread.sleep(1000)` : **Ctrl+C**.

Ensuite : remplacer `timeFlies` par une fonction anonyme (bloc du PDF). Vérifier que le comportement est identique.

**Notes :**


---

### Ex. 3–4 — Complex + toString

`Complex.scala` : classe `Complex` + object `ComplexNumber`.

1. Getteurs `re` / `im` **avec** `()`.
2. `main` qui instancie `1.2` / `3.4` et affiche l'imaginaire.
3. Lire les deux doubles depuis `args` (`sbt "runMain ComplexNumber 1.2 3.4"`).
4. Enlever les `()` des getteurs (accès façon champ).
5. `override def toString` pour coller **exactement** la phrase du PDF.

**Sortie toString obtenue :**


---

### Ex. 5 — Arbre, eval, derive

`Tree.scala` (case class) + `Calc.scala` (`eval` / `derive` / `main`).

`type Environment = String => Int` : une variable est un nom, l'environnement dit combien elle vaut.

Le PDF explique le `match` ligne à ligne — le relire avant de coller.

`derive` : `Var(n) if v == n` → `Const(1)`, le reste → `Const(0)` (pas de simplification de `Sum(Const(1), Const(1))`).

**Vérif :** coller dans `TP2.md` tes 4 blocs d'affichage (Expression / Evaluation / ∂x / ∂y).

**Notes (environnement y=7, forme de l'arbre) :**


---

### Ex. 6 — Trait Ord + Date

`Ord.scala` : compléter `<=` `>` `>=` (le PDF met `???`).  
`Date.scala` : `equals` ; `<` est déjà dans le squelette (exemple PDF).

Idée CM2 : le trait porte le code partagé. Si `<=` `>` `>=` sont définies **une fois** dans `Ord` à partir de `<` et `==`, `Date` n'a plus qu'à fournir `<` et `equals`.

Tester via `DateDemo` (pas dans le PDF : juste pour toi).

**Notes :**


---

## Partie 2 — HandsOn

Dossier **différent** : `02-handson/` (comme Minio vs HDFS au TP1).  
Le PDF Unix : `handson go`. Le getting started du repo : `./handson go`.

```bash
cd 02-handson/scala-class
sbt go
# le PDF : `handson go` / `./handson go` — le script du repo attend
# $SBT_HOME/bin/sbt-launch.jar (souvent absent). `sbt go` = le même alias.
```

`sbt go` = alias `~ testOnly HandsOnScala` : relance les tests à chaque sauvegarde.

IntelliJ : ouvrir le **`build.sbt`** du clone, « Open as Project », JDK récent, Scala SDK proposé par l'IDE.

Pièges PDF / getting_started :

- Fichier demandé : `e00_scala_syntax.scala` — **n'existe pas**. Ordre réel : `e00_start.scala` (intro, enlever `DeleteMeToContinue`) puis `e01_syntaxe.scala`.
- `scalaVersion` du HandsOn : **2.13.18** (pas 2.13.15 de la partie 1).
- Windows : commit figé `048f7bca…` + `handson.bat` — tu es sur macOS, branche par défaut.
- Remplir `__` (valeur) et `???` (code). Ne pas « finir » en copiant des solutions.

**Avancement (coche) :**

- [ ] e00 start
- [ ] e01 syntaxe
- [ ] e02 objet
- [ ] e03 collections
- [ ] e04 types fonctionnels
- [ ] e05 HoF
- [ ] e06 currying
- [ ] e07 implicit

---

## Capture de commandes / erreurs

Colle ici les extraits utiles (pas tout le log sbt « downloading ») :

```text

```
