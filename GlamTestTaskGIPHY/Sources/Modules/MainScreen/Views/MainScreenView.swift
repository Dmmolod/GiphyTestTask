//
//  MainScreenView.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import UIKit
import WaterfallLayout

protocol MainScreenViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
    func didScrollToEnd()
    func didSelectSection(_ type: MainSectionType)
}

final class MainScreenView: UIView {
    
    weak var delegate: MainScreenViewDelegate?
    
    //MARK: - Private Properties
    private let sectionsView = MainSectionsView()
    private let collection = MainGifCollectionView()
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupActions()
        setupLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    //MARK: - API
    func setFetchGifActionInCollection(_ action: @escaping (String, @escaping (Data?) -> ()) -> ()) {
        collection.fetchGifAction = action
    }
    
    func reloadCollection(with items: [GifModel]) {
        self.collection.updateItems(items)
    }
    
    func updateCollectionHeaderSections(with model: [String]) {
        self.sectionsView.addSections(with: model)
    }
    
    //MARK: - Private Methods
    private func setupActions() {
        
        sectionsView.didSelectSectionAction = { [weak self] info in
            self?.delegate?.didSelectSection(info.type)
            
            if self?.collection.visibleSize != .zero {
                self?.collection.scrollToItem(
                    at: .init(
                        item: 0,
                        section: 0
                    ),
                    at: .top,
                    animated: info.animated
                )
            }
        }
        
        collection.didScrollToEndAction = { [weak self] in
            self?.delegate?.didScrollToEnd()
        }
        
        collection.didSelectItemAction = { [weak self] indexPath in
            self?.delegate?.didSelectItem(at: indexPath)
        }
        
    }
    
    private func setupLayout() {
        addSubview(sectionsView) {
            $0.top.equalTo(self.snp.topMargin)
            $0.leading.trailing.width.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        addSubview(collection) {
            $0.top.equalTo(sectionsView.snp.bottom).offset(10)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}
