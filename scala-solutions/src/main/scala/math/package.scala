import scala.annotation.tailrec

package object math {
  @tailrec
  def gcd(a: Int, b: Int): Int =
    if b == 0 then a else gcd(b, a % b)
}
