//
//  LoginViewController.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import SwiftUI

class LoginViewController: UIViewController {
    
    //MARK: Properties
    private var logo              = UIImageView()
    private var name              = UILabel()
    private var message           = UILabel()
    private var phoneContainer    = UIView()
    private var passwordContainer = UIView()
    private var phone             = UITextField()
    private var password          = UITextField()
    private var phoneIcon         = UIImageView()
    private var passwordIcon      = UIImageView()
    private var loginButton       = UIButton(type : .system)
    private var registerButton    = UIButton()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}

//MARK: Create The UserInterface (UI)
private extension LoginViewController {
    @objc func handleRegister() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    @objc func handlePrestenHomeScreen() {
        dismiss(animated: true)
    }
    func setupActions() {
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handlePrestenHomeScreen), for: .touchUpInside)
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func setPasswordContainer() {
        //Container
        passwordContainer.backgroundColor = .tertiarySystemBackground
        passwordContainer.layer.cornerRadius = 12
        passwordContainer.constrainHeight(constant: 60)
        passwordContainer.shadow()
        
        //Text
        password.isSecureTextEntry = true
        password.constrainWidth(constant: 270)
        password.constrainHeight(constant: 59)
        password.borderStyle  = .none
        password.font = .verdanaLight
        password.attributedPlaceholder = NSAttributedString(string: "•••••••••••", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        
        //Icon
        passwordIcon           = UIImageView(SFSymbols.password)
        passwordIcon.tintColor = .systemGray
        
        let hStack = HStackView(arrangedSubviews: [passwordIcon,password],spacing: 5)
        passwordContainer.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor,constant: 16),
            hStack.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor)
        ])
    }
    func setPhoneContainer() {
        //Container
        phoneContainer.backgroundColor = .tertiarySystemBackground
        phoneContainer.layer.cornerRadius = 12
        phoneContainer.constrainHeight(constant: 60)
        phoneContainer.shadow()
        
        //Text
//        phone.backgroundColor = .blue
        phone.constrainWidth(constant: 270)
        phone.constrainHeight(constant: 59)
        phone.keyboardType = .phonePad
        phone.borderStyle  = .none
        phone.font = .verdanaLight
        phone.attributedPlaceholder = NSAttributedString(string: "0605040032", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        
        //Icon
        phoneIcon = UIImageView(SFSymbols.phone)
        phoneIcon.tintColor = .systemGray
        let hStack = HStackView(arrangedSubviews: [phoneIcon,phone],spacing: 5)
        phoneContainer.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor,constant: 16),
            hStack.centerYAnchor.constraint(equalTo: phoneContainer.centerYAnchor)
        ])
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
    func setLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .verdana
        loginButton.backgroundColor = UIColor(Color.buttonsColor)
        loginButton.layer.cornerRadius = 10
        loginButton.shadow()
        
    }
    func setReggisterButton() {
        registerButton = UIButton("Don't have an account?"," Create One")
        view.addSubview(registerButton)
        registerButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 10, right: 25))
    }
    
     func setupComponents() {
        setupImage()
        setMessage()
        setTitle()
        setPhoneContainer()
        setPasswordContainer()
        setLoginButton()
        setReggisterButton()
        dismissKeyBoard()
        setupActions()
    }
    
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.isHidden = true
        setupComponents()
        let stack = VerticalStackView(arrangedSubviews: [logo,name,message],spacing: 15)
        stack.alignment = .center
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        let vStack = VerticalStackView(arrangedSubviews: [phoneContainer,passwordContainer,loginButton], spacing: 25)
        
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}
struct LoginView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: LoginViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct LoginViewController_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .edgesIgnoringSafeArea(.all)
    }
}
