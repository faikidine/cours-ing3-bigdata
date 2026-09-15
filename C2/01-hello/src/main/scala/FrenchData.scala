// Ex1 suite — objet FrenchData (date localisée FR).
// Tu peux aussi le coller dans Hello.scala ; un object à part permet à
// `sbt run` de te demander quel main lancer (remarque CM2).
//
// Imports indiqués dans le PDF. Pièges : voir guide.md
// (LocalDate n'est pas dans java.lang ; withLocal vs withLocale).

import java.time.format.{DateTimeFormatter, FormatStyle}
import java.time.LocalDate
import java.util.Locale._

object FrenchData {
  def main(args: Array[String]): Unit = {
    // TODO : val now
    // TODO : val df  (FormatStyle.LONG + locale FRANCE)
    // TODO : afficher
  }
}
