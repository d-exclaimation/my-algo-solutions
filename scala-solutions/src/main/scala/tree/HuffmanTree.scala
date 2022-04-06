//
//  HuffmanTree.scala
//  scala-solutions
//
//  Created by d-exclaimation on 7:32 AM.
//


package tree

import scala.annotation.tailrec
import scala.collection.immutable.{AbstractSeq, LinearSeq}
import scala.collection.mutable

sealed trait HuffmanTree {
  def weight: Int


  final def combine(other: HuffmanTree): HuffmanTree =
    if (weight <= other.weight) HuffmanTree.Node(
      weight = weight + other.weight, zero = this, one = other
    )
    else HuffmanTree.Node(
      weight = weight + other.weight, zero = other, one = this
    )

  @tailrec
  final def decode(bits: Seq[Int], res: String = ""): String = {
    val (char, seq) = partialDecode(bits)
    if (seq.isEmpty) res + char.toString
    else decode(seq, res + char.toString)
  }


  @tailrec
  private def partialDecode(bits: Seq[Int]): (Char, Seq[Int]) = (bits, this) match {
    case (seq, HuffmanTree.Leaf(weight, value)) =>
      (value, seq)
    case (0 +: tail, HuffmanTree.Node(weight, zero, one)) =>
      zero.partialDecode(tail)
    case (1 +: tail, HuffmanTree.Node(weight, zero, one)) =>
      one.partialDecode(tail)
    case (_, HuffmanTree.Node(weight, zero, one)) =>
      (' ', Seq.empty)
  }

  @tailrec
  final def encode(str: String, res: Seq[Int] = Seq.empty): Seq[Int] = {
    str.filter(_.isLetterOrDigit).filter(!_.isSpaceChar).toSeq match {
      case Seq() => res
      case Seq(head, tail@_*) => encode(tail.toString(), res ++ partialEncode(head))
    }
  }

  private def partialEncode(char: Char, carry: Seq[Int] = Seq.empty): Seq[Int] = this match {
    case HuffmanTree.Node(_, zero, one) =>
      val res0 = zero.partialEncode(char, carry :+ 0)
      if (res0.nonEmpty) res0
      else one.partialEncode(char, carry :+ 1)
    case HuffmanTree.Leaf(_, value) if value == char => carry
    case HuffmanTree.Leaf(_, _) => Seq.empty
  }

  override final def toString = this match {
    case HuffmanTree.Node(weight, zero, one) =>
      s"($weight) { 0: $zero  1: $one }"
    case HuffmanTree.Leaf(weight, value) => s"($weight, $value)"
  }
}


object HuffmanTree {
  case class Node(weight: Int, zero: HuffmanTree, one: HuffmanTree) extends HuffmanTree
  case class Leaf(weight: Int, value: Char) extends HuffmanTree

  def apply(seq: Seq[(Int, Char)]): HuffmanTree = {
    val res = seq.map[HuffmanTree] { case (freq, char) => Leaf(freq, char) }.sortBy(_.weight)
    parse(res)
  }

  def apply(doc: String): HuffmanTree = {
    val map = doc
      .filter(_.isLetterOrDigit)
      .filter(!_.isSpaceChar)
      .foldLeft(Map.empty[Char, Int]) {
        case (acc, char) => acc.updated(char, acc.getOrElse(char, 0) + 1)
      }
      .toSeq
      .map { case (char, freq) => (freq, char) }
    apply(map)
  }

  @tailrec
  private def parse(seq: Seq[HuffmanTree]): HuffmanTree = seq match {
    case Seq() => HuffmanTree.Leaf(0, ' ')
    case Seq(head) => head
    case Seq(lhs, rhs, tail@_*) => {
      val node = lhs.combine(rhs)
      tail.indexWhere(_.weight >= node.weight) match {
        case -1 => parse(tail.appended(node))
        case i =>
          val (before, after) = tail.splitAt(i)
          parse(before ++ Seq(node) ++ after)
      }
    }
  }
}