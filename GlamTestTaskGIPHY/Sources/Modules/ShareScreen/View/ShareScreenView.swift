//
//  ShareScreenView.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 29.01.2023.
//

import UIKit
import Gifu

protocol ShareScreenViewDelegate: AnyObject {
    func didTapClose()
    func didTapShare()
    func didTapCopyLink()
    func didTapCancel()
    func didTapSave()
    func didSelectShare(_ type: ShareType)
}

final class ShareScreenView: UIView {
    
    weak var delegate: ShareScreenViewDelegate?
    
    //MARK: - Private Properties
    private let gifImageView = GIFImageView()
    private let closeButton = UIButton()
    private let shareButton = UIButton()
    private let shareBlockStackView = UIStackView()
    private let bottomButtonsStackView = UIStackView()
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .black

        setupShareBlockStackView()
        setupShareBlock()
        setupTopBarButtons()
        setupBottomButtonsStackView()
        setupBottomButtons()
        layout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    //MARK: - API
    func disappearGif() {
        gifImageView.prepareForReuse()
        gifImageView.image = nil
    }
    
    func setupGif(_ gifData: Data) {
        self.gifImageView.animate(withGIFData: gifData)
    }
    
    //MARK: - Target Methods
    @objc
    private func didTapClose() {
        delegate?.didTapClose()
    }

    @objc
    private func didTapShare() {
        delegate?.didTapShare()
    }
    
    @objc func didTapShareItem(_ sender: UIButton) {
        guard let type = ShareType.allCases[safe: sender.tag] else { return }
        delegate?.didSelectShare(type)
    }
    
    @objc
    private func didTapCopy() {
        delegate?.didTapCopyLink()
    }
    
    @objc
    private func didTapSave() {
        delegate?.didTapSave()
    }
    
    @objc
    private func didTapCancel() {
        delegate?.didTapCancel()
    }
}

//MARK: - Private Layout Methods
extension ShareScreenView {
    
    private func setupTopBarButtons() {
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        closeButton.setImage(
            UIImage(
                systemName: "multiply",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white),
            for: .normal
        )
            
        shareButton.setImage(
            UIImage(
                systemName: "square.and.arrow.up",
                withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white),
            for: .normal
        )
        
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        shareButton.addTarget(self,action: #selector(didTapShare),for: .touchUpInside)
    }
    
    private func setupShareBlockStackView() {
        shareBlockStackView.axis = .horizontal
        shareBlockStackView.distribution = .fillEqually
        shareBlockStackView.alignment = .fill
        shareBlockStackView.spacing = 10
    }
    
    private func setupShareBlock() {
        ShareType.allCases.enumerated().forEach {
            let shareButton = UIButton()
            shareButton.tag = $0
            let config = UIImage.SymbolConfiguration(pointSize: 40)
            shareButton.setImage(
                $1.image?.withConfiguration(config),
                for: .normal
            )
            shareButton.snp.makeConstraints { $0.height.width.equalTo(40) }
            shareButton.addTarget(self, action: #selector(didTapShareItem), for: .touchUpInside)
            
            shareBlockStackView.addArrangedSubview(shareButton)
        }
    }
    
    private func setupBottomButtonsStackView() {
        bottomButtonsStackView.axis = .vertical
        bottomButtonsStackView.alignment = .fill
        bottomButtonsStackView.distribution = .fillEqually
        bottomButtonsStackView.spacing = 10
    }
    
    private func setupBottomButtons() {
        let copyButton = UIButton()
        let saveButton = UIButton()
        let cancelButton = UIButton()
        
        copyButton.addTarget(self, action: #selector(didTapCopy), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        copyButton.setTitle("Copy link", for: .normal)
        copyButton.backgroundColor =  .cyan.withAlphaComponent(0.5)
        
        saveButton.setTitle("Save gif", for: .normal)
        saveButton.backgroundColor = .gray.withAlphaComponent(0.6)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .black
        
        [copyButton, saveButton, cancelButton].forEach {
            bottomButtonsStackView.addArrangedSubview($0)
        }
    }
    
    private func layout() {
        addSubview(closeButton) {
            $0.top.equalTo(self.snp.topMargin)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        
        addSubview(shareButton) {
            $0.top.size.equalTo(closeButton)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(gifImageView) {
            $0.top.equalTo(closeButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        
        let vStack = UIStackView(arrangedSubviews: [shareBlockStackView])
        vStack.axis = .vertical
        vStack.alignment = .center
        
        addSubview(vStack) {
            $0.top.equalTo(gifImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        addSubview(bottomButtonsStackView) {
            $0.top.equalTo(vStack.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(vStack)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
}
