//
//  UIColor+Extensions.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 24/06/2021.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static let primary = UIColor(r: 0, g: 39, b: 255, a: 0.6)
}
