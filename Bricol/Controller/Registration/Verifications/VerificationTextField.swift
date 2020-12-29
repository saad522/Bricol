//
//  VerificationTextField.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import SwiftUI

class VerificationTextField: UITextField {

    weak var veriDelegate: VerificationTextFieldDelegate?

    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: frame.width)
    }

    init(initialText: String = "") {
        super.init(frame: .zero)
        delegate = self
        setupTextField(initialText: initialText)
    }

    override func deleteBackward() {
        super.deleteBackward()
        veriDelegate?.deleteBackward(self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        font = .verdana
    }

    private func setupTextField(initialText: String) {
        keyboardType = .numberPad
        tintColor = .clear
        textAlignment = .center
        layer.cornerRadius = 12
        text = initialText
        isFocused()
    }

    fileprivate func isFocused(isFocused: Bool = false) {
        backgroundColor = isFocused ? UIColor.secondarySystemFill :.secondarySystemFill
        textColor = isFocused ? UIColor.black : UIColor(Color.titlesColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VerificationTextField: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        textField.text = string

        if let digit = text, Int(digit) != nil {
            veriDelegate?.nextTextField(textField)
        }
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        isFocused(isFocused: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isFocused()
    }
}
