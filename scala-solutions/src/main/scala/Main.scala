//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import option.??
import pipe.|>

@main def hello: Unit =
  Some(10000) ?? 0
    .toString
    .|>(append(_, "World"))
    .|>(println)

def append(s: String, r: String): String = s + " " + r
