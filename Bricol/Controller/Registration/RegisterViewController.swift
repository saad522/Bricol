//
//  RegisterViewController.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import SwiftUI
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    //MARK: Properties
    var homeViewController : HomeViewControllert?

    private var logo              = UIImageView()
    private var name              = UILabel()
    private var message           = UILabel()
    private var codeCountry       = UILabel()
    private var phoneContainer    = UIView()
    private var phone             = UITextField()
    private var verifyButton      = UIButton(type : .system)
    private var loginButton       = UIButton()
    private var viewLabel         = UIView()
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}

private extension RegisterViewController {
    @objc func handleLogin() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handelVerify() {
        guard let code = codeCountry.text, let number = phone.text else { return }
        let codePlusPhoneNumber = code + number
        print("Phone number with code country : ",codePlusPhoneNumber)
        Auth.auth().languageCode = "fr"
        PhoneAuthProvider.provider().verifyPhoneNumber(codePlusPhoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            if let error = error {
                print("DEBUG: Failed To verify This Phone Number reason : ",error.localizedDescription)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            print("DEBUG: Code Has Sent")
            let verficationViewController = VerificationViewControllert()
            verficationViewController.homeViewController = self?.homeViewController
            self?.navigationController?.pushViewController(VerificationViewControllert(), animated: true)
        }
       
    }
    func setupActions() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        verifyButton.addTarget(self, action: #selector(handelVerify), for: .touchUpInside)
    }
    func setupImage() {
        logo.image = #imageLiteral(resourceName: "Logo")
        logo.constrainWidth(constant: 87)
        logo.constrainHeight(constant: 87)
        logo.layer.cornerRadius = 12
        logo.clipsToBounds = true
    }
    func setTitle() {
        name.text = "Bricole"
        name.font = .verdana
        name.textColor = UIColor(Color.titlesColor)
    }
    func setMessage() {
        message.text = "Bring the best service to you"
        message.font = .verdanaLight
        message.textColor = .systemGray
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func setPhoneContainer() {
        //Container
        phoneContainer.backgroundColor = .tertiarySystemBackground
        phoneContainer.layer.cornerRadius = 12
        phoneContainer.constrainHeight(constant: 60)
        phoneContainer.shadow()
        
        //Text
        phone.keyboardType = .phonePad
        phone.borderStyle  = .none
        phone.font = .verdanaLight
        phone.constrainWidth(constant: 270)
        phone.constrainHeight(constant: 59)
        phone.attributedPlaceholder = NSAttributedString(string: "Enter phone number...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        

        let hStack = HStackView(arrangedSubviews: [phone],spacing: 5)
        phoneContainer.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor,constant: 16),
            hStack.centerYAnchor.constraint(equalTo: phoneContainer.centerYAnchor)
        ])
        
    }
    func setupCodeCountry() {
        codeCountry.text = "+212"
        codeCountry.font = .verdanaSmall
        codeCountry.textColor = .darkGray
        codeCountry.backgroundColor = .tertiarySystemBackground
        codeCountry.constrainWidth(constant: 50)
        codeCountry.constrainHeight(constant: 60)
        codeCountry.layer.cornerRadius = 12
        codeCountry.layer.masksToBounds = true
        viewLabel.addSubview(codeCountry)
        codeCountry.fillSuperview()
        viewLabel.shadow()
       
    }
    func setLoginButton() {
        verifyButton.setTitle("Verify", for: .normal)
        verifyButton.setTitleColor(.white, for: .normal)
        verifyButton.titleLabel?.font = .verdana
        verifyButton.backgroundColor = UIColor(Color.buttonsColor)
        verifyButton.layer.cornerRadius = 10
        verifyButton.shadow()
        
    }
    func setReggisterButton() {
        loginButton = UIButton("Already have an account?"," Login")
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 10, right: 25))
    }
    func setupComponents() {
        setupImage()
        setMessage()
        setTitle()
        setPhoneContainer()
        setupCodeCountry()
        setLoginButton()
        dismissKeyBoard()
//        setReggisterButton()
        setupActions()
    }
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        setupComponents()
        let vStack = VerticalStackView(arrangedSubviews: [logo,name,message],spacing: 15)
        vStack.alignment = .center
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        let hStack = HStackView(arrangedSubviews: [viewLabel,phoneContainer], spacing: 5)
        let stack = VerticalStackView(arrangedSubviews: [hStack,verifyButton], spacing: 45)
        view.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 55),
            
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
        
        
    }
}
struct RegisterView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: RegisterViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
}

struct RegisterViewController_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .edgesIgnoringSafeArea(.all)
    }
}
