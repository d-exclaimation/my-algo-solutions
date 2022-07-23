//
//  BinaryTree.swift
//  swift-solutions
//
//  Created by d-exclaimation on 16:11.
//

indirect enum BiTree<T: Equatable> {
    case node(T, left: BiTree<T>, right: BiTree<T>)
    case lnode(T, left: BiTree<T>)
    case rnode(T, right: BiTree<T>)
    case leaf(T)

    var value: T {
        switch (self) {
        case .leaf(let res):
            return res
        case .node(let res, left: _, right: _):
            return res
        case .rnode(let res, right: _):
            return res
        case .lnode(let res, left: _):
            return res
        }
    }
}

extension BiTree {
    func zipZag() -> Int {
        switch (self) {
        case .leaf(_):
            return 0
        case .lnode(_, left: let left):
            return 1 + left.zipCont(true)
        case .rnode(_, right: let right):
            return 1 + right.zipCont(false)
        case .node(_, left: let left, right: let right):
            return 1 + max(left.zipCont(true), right.zipCont(false))
        }
    }

    private func zipCont(_ isLeft: Bool) -> Int {
        switch (self) {
        case .leaf(_):
            return 0
        case .lnode(_, left: let left):
            return isLeft ? left.zipZag() : 1 + left.zipCont(true)
        case .rnode(_, right: let right):
            return isLeft ? 1 + right.zipCont(false) : right.zipZag()
        case .node(_, left: let left, right: let right):
            let leftCont = isLeft ? left.zipZag() : 1 + left.zipCont(true)
            let rightCont = isLeft ? 1 + right.zipCont(false) : right.zipZag()
            return max(leftCont, rightCont)
        }
    }
}