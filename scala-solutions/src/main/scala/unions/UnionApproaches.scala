//
//  UnionApproaches.scala
//  scala-solutions
//
//  Created by d-exclaimation on 12:13 AM.
//

package unions

object UnionApproaches {
  sealed trait Person

  trait Helpful {
    def help(): Unit
  }

  trait Charitable {
    def donate(money: Double): Unit

    def giveMoney(): Double
  }

  def handleBoth(person: Helpful | Charitable): Unit = person match {
    case (c0: Charitable) => cast[Charitable, Unit](c0) { c =>
      val curr: Double = c.giveMoney() - (Math.random() * 10)
      c.donate(curr)
    }
    case h: Helpful => h.help()
  }

  sealed trait MaybeOk
  case class Ok(k: String) extends MaybeOk {
    def ok(): Unit = ()
  }

  case class NotOk() extends MaybeOk


  def handleMaybe(m: MaybeOk): Unit = m match {
    case Ok(k) => ()
    case notOk: NotOk => ()
  }


  def cast[T, K](curr: Any)(fn: T => K): K =
    val res: T = curr.asInstanceOf[T]
    fn(res)
}
