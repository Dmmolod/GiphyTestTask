//
//  UIColor + Extension.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        var randomValue: CGFloat { .random(in: 0...1) }
        
        return UIColor(
            red: randomValue,
            green: randomValue,
            blue: randomValue,
            alpha: 1
        )
    }
}
