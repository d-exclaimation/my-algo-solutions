//
//  Employees.scala
//  scala-solutions
//
//  Created by d-exclaimation on 8:22 PM.
//

package math

object Employees {
  def averageSalaryWithoutOutlier0(salaries: Vector[Double]): Double = {
    val max = salaries.max // + O(n)
    val min = salaries.min // + O(n)

    val total = salaries
      .filter { salary => salary != max && salary != min } // + O(n)
      .sum // + O(n)
    total / (salaries.length.doubleValue - 2.0)
  }
}
