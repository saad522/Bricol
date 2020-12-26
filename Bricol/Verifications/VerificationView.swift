//
//  VerificationView.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import SwiftUI

protocol VerificationTextFieldDelegate: class {
    func nextTextField(_ textField: UITextField)
    func deleteBackward(_ textField: UITextField)
}

class VerificationView: UIView {

    var numberOfDigits: Int!
    var textFields: [UITextField] = []

    init(numberOfDigits: Int = 6) {
        self.numberOfDigits = numberOfDigits
        super.init(frame: .zero)

        layer.cornerRadius = 12
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor

        let stackView = UIStackView(arrangedSubviews: createVerificationTextFields(digits: numberOfDigits))
        stackView.spacing = 15
        
        stackView.distribution = .fillEqually
        stackView.constrainHeight(constant: 66)
        stackView.constrainWidth(constant: 45)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 15, bottom: 20, right: 15))
    }

    @discardableResult
    private func createVerificationTextFields(digits: Int) -> [UITextField] {
        for index in 0..<digits {
            let textField = VerificationTextField(initialText: "-")
            textField.tag = index
            textField.veriDelegate = self
            textFields.append(textField)
        }
        return textFields
    }

     func getCode() -> String {
        var code = ""
        for textField in textFields {
            code.append(textField.text ?? "")
        }

        return code
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VerificationView: VerificationTextFieldDelegate {

    func nextTextField(_ textField: UITextField) {
        if textField.tag < numberOfDigits - 1 {
            textFields[textField.tag + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            debugPrint(getCode())
        }
    }

    func deleteBackward(_ textField: UITextField) {
        if let digit = textField.text, !(digit.isEmpty) {
            return
        }
        textField.text = "-"
        if textField.tag > 0 {
            textFields[textField.tag - 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}


