//
//  MainSectionsView.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import UIKit

final class MainSectionsView: UIView {
    
    //MARK: - Public Properties
    var didSelectSectionAction: (((type: MainSectionType, animated: Bool)) -> ())?
    
    //MARK: - Private Properties
    private var buttons: [UIButton] = []
    private var currentSelected: MainSectionButton?
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        scrollView.showsHorizontalScrollIndicator = false
        
        addTrandingSection()
        setupStack()
        layout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    //MARK: - API
    func addSections(with model: [String]) {
        model.forEach {
            let newSectionButton = MainSectionButton(type: .category(name: $0))
            newSectionButton.addTarget(
                self,
                action: #selector(sectionDidSelect),
                for: .touchUpInside
            )
            
            buttons.append(newSectionButton)
            stackView.addArrangedSubview(newSectionButton)
        }
    }
    
    //MARK: - Target Methods
    @objc
    private func sectionDidSelect(_ sender: MainSectionButton) {
        let needAnimate = currentSelected?.type == sender.type
        currentSelected?.isSelected = false
        sender.isSelected = true
        
        currentSelected = sender
        
        didSelectSectionAction?((type: sender.type, animated: needAnimate))
    }
    
    //MARK: - Private Methods
    private func addTrandingSection() {
        let firstSection = MainSectionButton(type: .trandings)
        firstSection.isSelected = true
        firstSection.addTarget(
            self,
            action: #selector(sectionDidSelect),
            for: .touchUpInside
        )
        
        buttons.append(firstSection)
        stackView.addArrangedSubview(firstSection)
        currentSelected = firstSection
    }
    
    private func setupStack() {
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
    }
    
    private func layout() {
        addSubview(scrollView) {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView) {
            $0.edges.height.equalToSuperview()
        }
    }
}
