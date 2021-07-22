//
//  Clock.scala
//  Scala-Solutions
//
//  Created by d-exclaimation on 6:48 AM.
//

package math

object Clock {

  /**
   * Clock angle from the hour and minute hand
   * @param hours Floored value of the hour hand or the hour of time.
   * @param minute Value of the minute hand * 5 or the minutes passed.
   * @return A Double representing the angle.
   */
  def clockAngle(hours: Int, minute: Int): Double = {
    val angleEach = 360 / 12
    val hourHand: Double = (hours + (minute / 60.0)) * angleEach
    val minuteHand: Double = (minute / 5.0) * angleEach
    val res = Math.abs(minuteHand - hourHand)
    if (res == 360) 0 else res
  }
}
