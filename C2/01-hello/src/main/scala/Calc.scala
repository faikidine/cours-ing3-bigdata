import Tree._

// Ex5 — eval + derive par pattern matching, puis un main qui reproduit
// l'affichage du PDF.
//
// Le PDF donne `ev` avec seulement "x" -> 5. L'affichage attendu mentionne
// aussi y=7 : à toi d'étendre l'environnement.

object Calc {
  type Environment = String => Int
  val ev: Environment = { case "x" => 5 }

  def eval(t: Tree, ev: Environment): Int =
    ??? // TODO : match Sum / Var / Const (PDF)

  def derive(t: Tree, v: String): Tree =
    ??? // TODO : match Sum / Var(n) if v == n / case _ (PDF)

  def main(args: Array[String]): Unit = {
    // TODO : construire l'arbre de l'énoncé, println Expression / Evaluation /
    //        Derivative relative to x / y
  }
}
