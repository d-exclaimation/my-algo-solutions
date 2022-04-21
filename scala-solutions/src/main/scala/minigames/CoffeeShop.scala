//
//  CoffeeShop.scala
//  scala-solutions
//
//  Created by d-exclaimation on 18:51.
//

package minigames

object CoffeeShop {
  def maxHappyCustomers(
    customers: IndexedSeq[Int],
    stressed: IndexedSeq[Boolean],
    duration: Int
  ): Int = customers
    .indices
    .map { i =>
      stressed.zipWithIndex.map {
        case (_, j) if j >= i && j < (i + duration) => false
        case (stress, _) => stress
      }
    }
    .map { stressed =>
      customers
        .zip(stressed)
        .map {
          case (customer, stress) => if (stress) 0 else customer
        }
        .sum
    }
    .max
}
