import scala.annotation.tailrec

package object math {
  @tailrec
  def gcd(a: Int, b: Int): Int =
    if b == 0 then a else gcd(b, a % b)

  def inverseInZ(z: Int, x: Int): Option[Int] = gcd(z, x) match {
    case 1 => Some(bezoutIdentity(x, z)._1).map {
      case num if num < 0 => z + num
      case num => num
    }
    case _ => None
  }

  def bezoutIdentity(a: Int, b: Int): (Int, Int) = {
    val theirGcd = gcd(a, b)
    val (m, n) = loopBezoutIdentity(theirGcd, a, b)
    (m % (b / theirGcd), n % (-a / theirGcd))
  }

  @tailrec
  private def loopBezoutIdentity(
    gcd: Int, gcdGuess: Int, remain: Int,
    prevX: Int = 0, x: Int = 1, prevY: Int = 1, y: Int = 0
  ): (Int, Int) = {
    if (remain == 0 || gcd == gcdGuess) (x, y)
    else {
      val q = gcdGuess / remain
      loopBezoutIdentity(gcd,
        gcdGuess = remain,
        remain = gcdGuess % remain,
        prevX = x - q * prevX,
        x = prevX,
        prevY = y - q * prevY,
        y = prevY
      )
    }
  }

  def zStarMembers(z: Int): Seq[Int] =
    (1 until z).filter(gcd(_, z) == 1)


  extension (i: Int) {
    def isPrime: Boolean = {
      !(2 to (i / 2)).map(i % _).contains(0)
    }
  }



  @tailrec
  def divideInZ2(div: Seq[Int], root: Seq[Int]): Seq[Int] =
    if (root.length < div.length) root
    else {
      val eq = Seq.fill(root.length - div.length)(0) ++ div
      val res = root
        .zipAll(eq, 0, 0)
        .map {
          case (lhs, rhs) => (lhs - rhs) % 2
        }
        .map(scala.math.abs)
      divideInZ2(div, trimZerosPoly(res))
    }

  def trimZerosPoly(poly: Seq[Int]): Seq[Int] =
    poly.reverse.foldLeft((List.empty[Int], true)) {
      case ((acc, true), 0) => (acc, true)
      case ((acc, true), 1) => (1 :: acc, false)
      case ((acc, false), i) => (i :: acc, false)
    }._1

  def printPolyinZ2(seq: Seq[Int]) =
    if (seq.isEmpty) println("0")
    else println(seq.zipWithIndex.flatMap { case (x, i) => if (x == 0) None else if (i == 0) Some("1") else Some(s"x^$i") }.reverse.mkString(" + "))


  def lfsr(c: Seq[Int], s: Seq[Int]): Int = {
    c.zip(s)
      .map {
        case (ci, si) => if (ci > 0 && si > 0) 1 else 0
      }
      .sum % 2
  }

  def lfsrNext(c: Seq[Int], s: Seq[Int]): Seq[Int] = s
    .reverse
    .tail
    .appended(lfsr(c, s))
    .reverse

  def lfsrPeriod(c: Seq[Int], s: Seq[Int]): Int =
    lfsrPeriodRec(c, s, s)

  @tailrec
  private def lfsrPeriodRec(c: Seq[Int], s: Seq[Int], original: Seq[Int], count: Int = 0): Int =
    if (count != 0 && original == s) count
    else {
      lfsrPeriodRec(c, lfsrNext(c, s), original, count + 1)
    }
}
