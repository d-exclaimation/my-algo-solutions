//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

@main def main: Unit = {
  val res = Hello(name = "Vin")
  println("Construction")
  println(res.greetings)
  println(res.greetings)
  println(res.greetings)
}

case class Hello(
  name: String
) {
  def greetings: String = {
    println("Greetings called")
    s"Hello from $name"
  }
}



