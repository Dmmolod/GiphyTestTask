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
    var currentBackgroudColor: UIColor? { gifImageView.backgroundColor }
    private(set) var dataIsNowLoading = false
    
    //MARK: - Private Properties
    private let shimmerAnimationKey = "shimmer"
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
        
        gifImageView.image = nil
        gifImageView.prepareForReuse()
        
        stopShimmering()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shimmerLayer?.frame.size.height = contentView.bounds.height
    }
    
    //MARK: - API
    func configure(with model: MainGifCollectionViewModel, cachedColor: UIColor?) {
        if gifLink == model.gifLink { return }
        
        gifLink = model.gifLink
        
        gifImageView.backgroundColor = cachedColor ?? .random
        
        startShimmering()
        model.fetchGifAction?(gifLink) { [weak self] gifData in
            guard let gifData,
                  model.gifLink == self?.gifLink
            else { return }
            
            self?.stopShimmering()
            
            let freezeImage = UIImage(data: gifData)
            self?.gifImageView.image = freezeImage
            self?.gifImageView.animate(withGIFData: gifData)
            self?.dataIsNowLoading = true
        }
    }
    
    private func layout() {
        contentView.addSubview(gifImageView) {
            $0.edges.equalToSuperview()
        }
    }
    
    private func startShimmering() {
        let black = UIColor.black.withAlphaComponent(0.2).cgColor
        let clear = UIColor.clear.cgColor
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        
        let gradient = CAGradientLayer()
        gradient.colors = [clear, black, clear]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.1, 0.2, 0.3]
        gradient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        contentView.layer.addSublayer(gradient)
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.25
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: shimmerAnimationKey)
        
        shimmerLayer = gradient
        contentView.layer.masksToBounds = true
    }
    
    private func stopShimmering() {
        shimmerLayer?.removeAllAnimations()
        shimmerLayer?.removeFromSuperlayer()
        shimmerLayer = nil
    }
}
