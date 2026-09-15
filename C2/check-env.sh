#!/bin/bash
# Contrôles rapides avant / pendant le TP2 (ne lance rien).
set -u

ok() { printf "  [ok]  %s\n" "$1"; }
ko() { printf "  [!!]  %s\n" "$1"; }
info() { printf "  [..]  %s\n" "$1"; }

echo "== Pré-requis TP2 =="

if command -v java >/dev/null; then
  java -version 2>&1 | head -1 | sed 's/^/  [..]  /'
  echo "       PDF : Java via sdkman (surtout Partie 2). Homebrew 25 : le dépôt"
  echo "       HandsOn a été mis à jour pour Java 25. Si 2.13.15 râle : openjdk@17."
else
  ko "java absent"
fi

if [[ -x /opt/homebrew/opt/openjdk@17/bin/java ]]; then
  ok "openjdk@17 présent ($(/opt/homebrew/opt/openjdk@17/bin/java -version 2>&1 | head -1))"
else
  info "openjdk@17 absent (secours possible si Scala 2.13.15 refuse le JDK 25)"
fi

if command -v sbt >/dev/null; then
  ok "sbt $(sbt --script-version 2>/dev/null || sbt --version 2>/dev/null | head -1)"
else
  ko "sbt absent — PDF : dernière version via sdkman (Homebrew : brew install sbt)"
fi

if command -v scala >/dev/null; then
  if scala -version >/tmp/tp2-scala-ver.txt 2>&1; then
    ver=$(head -1 /tmp/tp2-scala-ver.txt)
    echo "  [..]  scala : $ver"
    if echo "$ver" | grep -q '2\.13'; then
      ok "CLI scala en 2.13.x (attendu pour scalac/scala de l'Ex1)"
    else
      ko "CLI scala n'est pas en 2.13.x — Ex1 (scalac Hello.scala) va coincer"
      echo "       cs install --force scala:2.13.15"
    fi
  else
    ko "scala présent mais cassé (wrapper Coursier / cache manquant ?)"
    echo "       cs install --force scala:2.13.15"
  fi
else
  ko "scala absent — nécessaire pour le passage scalac/scala de l'Ex1 (sbt run suffit sinon)"
  echo "       cs install --force scala:2.13.15"
fi

if command -v scalac >/dev/null; then
  if scalac -version >/tmp/tp2-scalac-ver.txt 2>&1; then
    info "scalac : $(head -1 /tmp/tp2-scalac-ver.txt)"
  else
    ko "scalac présent mais inexécutable"
  fi
else
  ko "scalac absent"
fi

if command -v cs >/dev/null; then
  ok "coursier (cs) $(cs version 2>/dev/null | head -1)"
else
  info "cs (coursier) absent — optionnel si sbt + scala 2.13 sont déjà là"
fi

if [[ -d "$HOME/.sdkman" ]]; then
  ok "sdkman installé"
else
  info "sdkman absent (le PDF le recommande ; sbt Homebrew + Java 25 peuvent suffire)"
fi

if command -v git >/dev/null; then
  ok "git $(git --version | awk '{print $3}')"
else
  ko "git absent (clone HandsOn)"
fi

if [[ -d "/Applications/IntelliJ IDEA.app" ]]; then
  ok "IntelliJ IDEA.app"
else
  ko "IntelliJ IDEA.app absent — https://www.jetbrains.com/idea/download/"
fi

scala_plugin=""
for d in \
  "$HOME/Library/Application Support/JetBrains/IntelliJIdea2026.2/plugins/Scala" \
  "$HOME/Library/Application Support/JetBrains/IntelliJIdea2026.1/plugins/Scala" \
  "$HOME/Library/Application Support/JetBrains/IntelliJIdea2025.3/plugins/Scala"
do
  if [[ -d "$d" ]]; then scala_plugin="$d"; break; fi
done
if [[ -n "$scala_plugin" ]]; then
  ok "plugin IntelliJ Scala ($scala_plugin)"
else
  ko "plugin Scala IntelliJ non trouvé — l'installer au premier lancement"
fi

echo
echo "== Fichiers de travail =="
here="$(cd "$(dirname "$0")" && pwd)"
cd "$here"
for f in \
  TP2.md TP2-BigData.pdf CM2-BD-Scala.pdf guide.md \
  01-hello/build.sbt \
  01-hello/src/main/scala/garden/bots/Hello.scala \
  01-hello/src/main/scala/FrenchData.scala \
  01-hello/src/main/scala/Timer.scala \
  01-hello/src/main/scala/Complex.scala \
  01-hello/src/main/scala/Tree.scala \
  01-hello/src/main/scala/Calc.scala \
  01-hello/src/main/scala/Ord.scala \
  01-hello/src/main/scala/Date.scala \
  02-handson/README.md
do
  if [[ -e $f ]]; then ok "$f"; else ko "$f manquant"; fi
done

if [[ -d 02-handson/scala-class/.git ]]; then
  ok "02-handson/scala-class (clone HandsOn)"
else
  info "02-handson/scala-class pas encore cloné — voir 02-handson/README.md"
fi
