//
//  UIView+Extension.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 05/07/2021.
//

import UIKit

enum Edge {
    case left
    case top
    case right
    case bottom
}

extension UIView {
    func pinToSuperviewEdges(_ edges: [Edge] = [.left, .top, .right, .bottom], constant: CGFloat = 0) {
        guard let superview = superview else { return }
        edges.forEach {
            switch $0 {
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}

