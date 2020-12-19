//
//  VerificationViewControllert.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import SwiftUI

class VerificationViewControllert: UIViewController {
    
    private var resendCodeButton   = UIButton(type : .system)
    private var resendCodeIcon     = UIImageView()
    private lazy var confirmButton = setupButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}

private extension VerificationViewControllert {
    @objc func handleResendCode() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleNext() {
        navigationController?.pushViewController(LookingForViewController(), animated: true)
    }
    func setActions() {
        resendCodeButton.addTarget(self, action: #selector(handleResendCode), for: .touchUpInside)
    }
    func setupResendCodeButton() {
        //Resend Code Icon
        resendCodeIcon = UIImageView(SFSymbols.resendCode,size: 16,UIColor(Color.buttonsColor))
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.verdanaLight,
            .foregroundColor: UIColor(Color.buttonsColor),
              .underlineStyle: NSUnderlineStyle.single.rawValue]
        resendCodeButton.setTitle("Resend Code", for: .normal)
        resendCodeButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        let attributeString = NSMutableAttributedString(string: "Resend Code", attributes: attributes)
        resendCodeButton.setAttributedTitle(attributeString, for: .normal)
    }
    func creatUI() {
        setupResendCodeButton()
        setActions()
        view.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        let veriView = VerificationView(numberOfDigits: 6)
        view.addSubview(veriView)
        veriView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.leadingAnchor,
                        bottom: nil,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 100, left: 15, bottom: 0, right: 15))

       
        view.addSubview(confirmButton)
        confirmButton.anchor(top: veriView.bottomAnchor,
                      leading: view.leadingAnchor,
                      bottom: nil,
                      trailing: view.trailingAnchor,
                      padding: .init(allInset: 32))
        
        let hStack = HStackView(arrangedSubviews: [resendCodeIcon,resendCodeButton],spacing: 5)
        
        view.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 35),
            hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupButton() -> UIButton {
        let button = ConfirmButton()
        button.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        return button
    }
    @objc private func handleTap(_ sender: UIButton) {
        if let button = sender as? ConfirmButton {
            button.iconView.animateArrow()
            button.pulse()
            perform(#selector(handleNext), with: self, afterDelay: 0.5)
        }
    }
}
struct VerificationViews: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: VerificationViewControllert())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct VerificationViewControllert_Previews: PreviewProvider {
    static var previews: some View {
        VerificationViews()
            .edgesIgnoringSafeArea(.all)
    }
}
