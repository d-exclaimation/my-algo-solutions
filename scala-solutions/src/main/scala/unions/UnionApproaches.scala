//
//  UnionApproaches.scala
//  scala-solutions
//
//  Created by d-exclaimation on 12:13 AM.
//

package unions

object UnionApproaches {
  trait Helpful {
    def help(): Unit
  }

  trait Charitable {
    def donate(money: Double): Unit

    def giveMoney(): Double
  }

  def handleBoth(person: Helpful | Charitable): Unit = person match {
    case c: Charitable =>
      val curr: Double = c.giveMoney() - (Math.random() * 10)
      c.donate(curr)

    case h: Helpful => h.help()
  }
}
