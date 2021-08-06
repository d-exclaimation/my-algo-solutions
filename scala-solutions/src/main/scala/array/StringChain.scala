//
//  StringChain.scala
//  scala-solutions
//
//  Created by d-exclaimation on 7:37 PM.
//

package array

object StringChain {

  sealed abstract class Chain {
    def length: Int
  }

  case class ChainAxon(
    curr: String,
    next: Chain
  ) extends Chain {
    override def length: Int = 1 + next.length
  }

  case class ChainNode(
    curr: String
  ) extends Chain {
    override def length: Int = 1
  }


  def chainSize(s: Seq[String]): Int = s
    .map(str => createChain(str, s.filter(_ != str)))
    .map(_.length)
    .max

  def createChain(start: String, others: Seq[String]): Chain = {
    val validLengthOthers = others.filter(_.length - start.length == 1)
    val chainable = others.filter(missingCount(start, _) == 1)
    if (chainable.isEmpty)
      ChainNode(start)
    else
      chainable
        .map(curr => ChainAxon(start, createChain(curr, others.filter(_ != curr))))
        .maxBy(_.length)
  }

  def missingCount(lhs: String, rhs: String): Int = (lhs.toCharArray, rhs.toCharArray) match {
    case (Array(lh, lt: _*), Array(rh, rt: _*)) => {
      if (lh != rh) 1 + missingCount(lhs, rt.mkString)
      else 0 + missingCount(lt.mkString, rt.mkString)
    }
    case _ => rhs.length
  }

}

