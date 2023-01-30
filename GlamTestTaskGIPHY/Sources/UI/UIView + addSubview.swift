//
//  UIView + addSubview.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import UIKit
import SnapKit

extension UIView {
    
    func addSubview(_ view: UIView, _ layout: (ConstraintMaker) -> ()) {
        addSubview(view)
        view.snp.makeConstraints(layout)
    }
    
}
