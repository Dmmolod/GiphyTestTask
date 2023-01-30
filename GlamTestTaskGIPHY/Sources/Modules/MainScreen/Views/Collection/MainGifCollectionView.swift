//
//  GifCollectionView.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import UIKit
import WaterfallLayout

final class MainGifCollectionView: UICollectionView {
    
    //MARK: - Public Properties
    var didSelectItemAction: ((IndexPath) -> ())?
    var didScrollToEndAction: (() -> ())?
    var fetchGifAction: ((String, @escaping (Data?) -> () ) -> ())?
    
    //MARK: - Private Properties
    private var items: [GifModel] = []
    
    //MARK: - Initializers
    init() {
        let layout = WaterfallLayout()
        layout.minimumColumnSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.numberOfColumns = 2
        
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }

    required init?(coder: NSCoder) { nil }
    
    //MARK: - API
    func updateItems(_ items: [GifModel]) {
        self.items = items
        reloadData()
    }

    //MARK: - Private Methods
    private func setup() {
        register(
            MainGifCollectionViewCell.self,
            forCellWithReuseIdentifier: MainGifCollectionViewCell.identifier
        )
        
        dataSource = self
        delegate = self
    }
}

//MARK: - Collection DataSource
extension MainGifCollectionView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let model = items[safe: indexPath.item] else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainGifCollectionViewCell.identifier,
            for: indexPath
        )
        let cellModel = MainGifCollectionViewModel(
            gifLink: model.mediumLink,
            fetchGifAction: fetchGifAction
        )
        (cell as? MainGifCollectionViewCell)?.configure(with: cellModel)
        
        return cell
    }
    
}

//MARK: - Collection Delegate
extension MainGifCollectionView: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let gifCell = collectionView.cellForItem(at: indexPath) as? MainGifCollectionViewCell,
              gifCell.dataIsNowLoading
        else { return }
        
        didSelectItemAction?(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
            didScrollToEndAction?()
        }
    }
}

//MARK: - Waterfall Layout Delegate
extension MainGifCollectionView: UICollectionViewDelegateWaterfallLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let height = items[indexPath.item].height
        let halfWidth = collectionView.bounds.width / 2
        
        return CGSize(width: halfWidth, height: height)
    }
    
}
