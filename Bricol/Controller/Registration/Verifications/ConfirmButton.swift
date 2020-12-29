//
//  ConfirmButton.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import UIKit

class ConfirmButton: UIButton {

    let iconView = IconView()

    init() {
        super.init(frame: .zero)
        setupButton()
        setupStackView()
    }

    private func setupButton() {
        backgroundColor = .quaternaryLabel
        layer.cornerRadius = 12
        clipsToBounds = true
    }

    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [UILabel.init(text: "Confirm",font: .verdanaLight,textColor: .white), iconView])
        stackView.isUserInteractionEnabled = false

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

