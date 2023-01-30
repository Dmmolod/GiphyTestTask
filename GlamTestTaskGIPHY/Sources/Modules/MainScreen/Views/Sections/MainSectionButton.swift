//
//  MainSectionButton.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 30.01.2023.
//

import UIKit

final class MainSectionButton: UIButton {
    
    //MARK: - Override Propeties
    override var intrinsicContentSize: CGSize {
        let titleSize = titleLabel?.intrinsicContentSize ?? .zero
        return CGSize(
            width: titleSize.width == 0 ? 0 : titleSize.width + 30 ,
            height: frame.height
        )
    }
    
    override var isSelected: Bool {
        willSet {
            backgroundColor = newValue ? selectedColor : defaultColor
        }
    }
    
    //MARK: - Public Properties
    private(set) var type: MainSectionType
    
    //MARK: - Private Properties
    private let selectedColor: UIColor = .cyan.withAlphaComponent(0.5)
    private let defaultColor: UIColor = .clear
    
    //MARK: - Initializers
    init(type: MainSectionType) {
        self.type = type
        super.init(frame: .zero)
        
        backgroundColor = defaultColor
        setTitleColor(.systemGray2, for: .normal)
        setTitleColor(.white, for: .selected)
        
        let title: String
        
        switch type {
        case .trandings: title = "Trandings"
        case .category(let name): title = name.capitalized
        }
        
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) { nil }

    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height/2
    }
}
