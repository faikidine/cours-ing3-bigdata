// Ex6 — Date extends Ord.
// Le PDF numérote 1, 2, puis 4 (pas de 3).
// `<` ci-dessous = exemple de l'énoncé (pour que le projet compile dès l'Ex1).
// À toi : equals, les 3 méthodes de Ord.scala, et DateDemo.

class Date(y: Int, m: Int, d: Int) extends Ord {
  def year = y
  def month = m
  def day = d
  override def toString(): String = s"$year-$month-$day"

  override def equals(that: Any): Boolean = ???

  def <(that: Any): Boolean = that match {
    case d: Date =>
      (year < d.year) ||
      (year == d.year && (month < d.month ||
                         (month == d.month && day < d.day)))
    case _ => sys.error("cannot compare " + that + " and a Date")
  }
}

object DateDemo {
  def main(args: Array[String]): Unit = {
    // TODO : deux-trois dates, equals / < / <= / > / >=
  }
}
