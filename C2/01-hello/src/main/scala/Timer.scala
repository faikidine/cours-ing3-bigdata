// Ex2 — fonctions d'objet + callback `() => Unit`.
// Le PDF dit « onePerSecond » dans le texte, le code s'appelle `oncePerSecond`.
// Boucle infinie : Ctrl+C pour arrêter.

object Timer {
  def oncePerSecond(callback: () => Unit): Unit = {
    // TODO : while (true) { callback ; sleep 1s }
  }

  def timeFlies(): Unit = {
    // TODO
  }

  def main(args: Array[String]): Unit = {
    // TODO : oncePerSecond(timeFlies)
    // TODO ensuite : version anonyme () => println(...)
  }
}
