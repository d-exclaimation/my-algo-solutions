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
}
