// Ex6 — trait = interface + code (CM2).
// `<` reste abstraite ; les trois autres s'expriment à partir de `<` et `==`.
// Ne les recopie pas sur Date si elles sont déjà dans le trait.

trait Ord {
  def <(that: Any): Boolean
  def <=(that: Any): Boolean = ???
  def >(that: Any): Boolean = ???
  def >=(that: Any): Boolean = ???
}
