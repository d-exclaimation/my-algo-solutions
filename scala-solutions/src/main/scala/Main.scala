//
//  Optional.scala
//  dotty-solutions
//
//  Created by d-exclaimation on 17:09..
//

import option.??
import pipe.|>
import array.NumericalSeq

@main def hello: Unit = {
  List(1, 9, 13, 22)
    .|>(NumericalSeq.missingKth(_, 4))
    .|>(println)
}
