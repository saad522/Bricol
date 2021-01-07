//
//  VerificationViewControllert.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class VerificationViewControllert: UIViewController {
    var homeViewController : HomeViewControllert?

    let verificationId = UserDefaults.standard.string(forKey: "authVerificationID")
    private var resendCodeButton   = UIButton(type : .system)
    private var resendCodeIcon     = UIImageView()
    let image = UIImageView()
    let message = UILabel()
    
    let veriView = VerificationView(numberOfDigits: 6)
    private lazy var confirmButton = setupButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        
    }
}

private extension VerificationViewControllert {
    func setupImagge() {
        image.image = #imageLiteral(resourceName: "logo-1")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.constrainWidth(constant: 100)
        image.constrainHeight(constant: 100)
        message.text = "Enter the code you get From SMS"
        message.font = .verdanaTitle
        message.textColor = UIColor(Color.titlesColor)
        message.textAlignment = .center
        message.numberOfLines = 2
    }
    @objc func handleResendCode() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleNext() {
        let lookingForViewController = LookingForViewController()
        lookingForViewController.homeViewController = homeViewController
        navigationController?.pushViewController(lookingForViewController, animated: true)
    }
    func setActions() {
        resendCodeButton.addTarget(self, action: #selector(handleResendCode), for: .touchUpInside)
    }
    func setupResendCodeButton() {
        //Resend Code Icon
        resendCodeIcon = UIImageView(SFSymbols.resendCode,size: 16,#colorLiteral(red: 0.2510487437, green: 0.7235888243, blue: 0.7010781169, alpha: 1))
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.verdanaLight,
            .foregroundColor: #colorLiteral(red: 0.2510487437, green: 0.7235888243, blue: 0.7010781169, alpha: 1),
              .underlineStyle: NSUnderlineStyle.single.rawValue]
        resendCodeButton.setTitle("Resend Code", for: .normal)
        resendCodeButton.setTitleColor(#colorLiteral(red: 0.2510487437, green: 0.7235888243, blue: 0.7010781169, alpha: 1), for: .normal)
        let attributeString = NSMutableAttributedString(string: "Resend Code", attributes: attributes)
        resendCodeButton.setAttributedTitle(attributeString, for: .normal)
    }
    func creatUI() {
        setupResendCodeButton()
        setActions()
        setupImagge()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        let vStackImagge = VerticalStackView(arrangedSubviews: [image,message], spacing: 5)
        
        let stack = VerticalStackView(arrangedSubviews: [vStackImagge,veriView], spacing: 15)
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.leadingAnchor,
                        bottom: nil,
                        trailing: view.trailingAnchor,
                        padding: .init(top: 15, left: 15, bottom: 0, right: 15))

       
        view.addSubview(confirmButton)
        confirmButton.anchor(top: stack.bottomAnchor,
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
            guard let verificationID = verificationId else { return  }
            let verificationCode = veriView.getCode()
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID,
                verificationCode: verificationCode)
            Auth.auth().signIn(with: credential) { [weak self] (authData, error) in
                if let error = error {
                    print("Error To Sign in User reason :",error.localizedDescription)
                    return
                }
                let database = Firestore.firestore()
                guard let userID = authData?.user.uid else {return }
                database.collection(DB_Keys.usersCollectionKey).document(userID).getDocument { (documentSnapshot, error) in
                    if let error = error {
                        print("Error : ",error.localizedDescription)
                        return
                    }
                    if documentSnapshot?.exists == true {
                        self?.homeViewController?.fetchUserData()
                        self?.dismiss(animated: true)
                        print("Cods get Tapped : ",self?.veriView.getCode() ?? "")
                    } else {
                            print("We did it 👍🏿")
                            let vc = LookingForViewController()
                       
                            self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}

enum DB_Keys {
    static let usersCollectionKey  = "users"
    static let postsCollectionKey  = "posts"
    static let reviewCollectionKey = "review"
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
