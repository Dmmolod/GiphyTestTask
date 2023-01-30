//
//  ToastMessageView.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 30.01.2023.
//

import UIKit

final class ToastMessageView: UIView {

    private let messageLabel = UILabel()

    init(message text: String) {
        super.init(frame: .zero)

        self.messageLabel.text = text

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        backgroundColor = .systemGray5
        layer.cornerRadius = 24

        layout()
    }

    private func layout() {
        addSubview(messageLabel) {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
