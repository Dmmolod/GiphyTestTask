//
//  GifCollectionViewCell.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import UIKit
import Gifu

final class MainGifCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Properties
    private(set) var dataIsNowLoading = false
    
    //MARK: - Private Properties
    private var shimmerLayer: CALayer?
    private let gifImageView = GIFImageView()
    private var gifLink = ""
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataIsNowLoading = false
        
        gifImageView.prepareForReuse()
        gifImageView.image = nil
        
        shimmerLayer?.removeFromSuperlayer()
        shimmerLayer = nil
    }
    
    //MARK: - API
    func configure(with model: MainGifCollectionViewModel) {
        gifLink = model.gifLink
        
        gifImageView.backgroundColor = .random
        
        showLoading()
        model.fetchGifAction?(gifLink) { [weak self] gifData in
            guard let gifData,
                  model.gifLink == self?.gifLink
            else { return }
            
            self?.shimmerLayer?.removeFromSuperlayer()
            self?.gifImageView.animate(withGIFData: gifData)
            self?.dataIsNowLoading = true
        }
    }
    
    //MARK: - Private Methods
    private func showLoading() {
        let light = UIColor(white: 0, alpha: 0.1).cgColor

        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, light, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.4, 0.5, 0.6]

        gradient.frame = CGRect(
            x: -contentView.bounds.width,
            y: 0, width: contentView.bounds.width * 3,
            height: contentView.bounds.height
        )

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]

        animation.repeatCount = .infinity
        animation.duration = 1.1
        animation.isRemovedOnCompletion = false

        gradient.add(animation, forKey: "shimmer")
        
        contentView.layer.addSublayer(gradient)
        
        shimmerLayer = gradient
    }
    
    private func layout() {
        contentView.addSubview(gifImageView) {
            $0.edges.equalToSuperview()
        }
    }
}
