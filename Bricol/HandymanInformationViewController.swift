//
//  HandymanInformationViewController.swift
//  Bricol
//
//  Created by mac on 12/19/20.
//

import SwiftUI

class HandymanInformationViewController: UIViewController {
    //MARK: Properties
    private var logo              = UIImageView()
    private var firstMessage      = UILabel()
    private var message           = UILabel()
    private var secondeMessage    = UILabel()
    private var fullNameContainer = UIView()
    private var fullName          = UITextField()
    private var livingContainer   = UIView()
    private var living            = UITextField()
    private var skillsContainer   = UIView()
    private var skills            = UITextField()
    private var passwordContainer = UIView()
    private var password          = UITextField()
    private var nextButton        = UIButton(type : .system)
    private var previousButton    = UIButton(type : .system)
    
    private var yContainer = UIView()
    private var y          = UITextField()
    private var xContainer = UIView()
    private var x          = UITextField()
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        print("All Good 👍🏼")
    }
}
private extension HandymanInformationViewController {
    @objc func handlePreviousButton() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleNext() {
        dismiss(animated: true)
    }
    func setActions() {
        previousButton.addTarget(self, action: #selector(handlePreviousButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    func setFullNameContainer() {
        //Container
        fullNameContainer.backgroundColor = .tertiarySystemBackground
        fullNameContainer.layer.cornerRadius = 12
        fullNameContainer.constrainHeight(constant: 60)
        fullNameContainer.shadow()
        
        //Text
        fullName.constrainWidth(constant: 270)
        fullName.constrainHeight(constant: 59)
        fullName.borderStyle  = .none
        fullName.font = .verdanaLight
        fullName.attributedPlaceholder = NSAttributedString(string: "What’s your Full-Name?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        fullNameContainer.addSubview(fullName)
        fullName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullName.leadingAnchor.constraint(equalTo: fullNameContainer.leadingAnchor,constant: 16),
            fullName.centerYAnchor.constraint(equalTo: fullNameContainer.centerYAnchor)
        ])
    }
    func setLivingContainer() {
        //Container
        livingContainer.backgroundColor = .tertiarySystemBackground
        livingContainer.layer.cornerRadius = 12
        livingContainer.constrainHeight(constant: 60)
        livingContainer.shadow()
        
        //Text
        living.constrainWidth(constant: 270)
        living.constrainHeight(constant: 59)
        living.borderStyle  = .none
        living.font = .verdanaLight
        living.attributedPlaceholder = NSAttributedString(string: "Where you are living?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        livingContainer.addSubview(living)
        living.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            living.leadingAnchor.constraint(equalTo: livingContainer.leadingAnchor,constant: 16),
            living.centerYAnchor.constraint(equalTo: livingContainer.centerYAnchor)
        ])
    }
    func setSkillsContainer() {
        //Container
        skillsContainer.backgroundColor = .tertiarySystemBackground
        skillsContainer.layer.cornerRadius = 12
        skillsContainer.constrainHeight(constant: 60)
        skillsContainer.shadow()
        
        //Text
        skills.constrainWidth(constant: 270)
        skills.constrainHeight(constant: 59)
        skills.borderStyle  = .none
        skills.font = .verdanaLight
        skills.attributedPlaceholder = NSAttributedString(string: "What’s your skills?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        skillsContainer.addSubview(skills)
        skills.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skills.leadingAnchor.constraint(equalTo: skillsContainer.leadingAnchor,constant: 16),
            skills.centerYAnchor.constraint(equalTo: skillsContainer.centerYAnchor)
        ])
    }
    func setPasswordContainer() {
        //Container
        passwordContainer.backgroundColor = .tertiarySystemBackground
        passwordContainer.layer.cornerRadius = 12
        passwordContainer.constrainHeight(constant: 60)
        passwordContainer.shadow()
        
        //Text
        password.constrainWidth(constant: 270)
        password.constrainHeight(constant: 59)
        password.isSecureTextEntry = true
        password.borderStyle  = .none
        password.font = .verdanaLight
        password.attributedPlaceholder = NSAttributedString(string: "Create password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        
        passwordContainer.addSubview(password)
        password.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            password.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor,constant: 16),
            password.centerYAnchor.constraint(equalTo: passwordContainer.centerYAnchor)
        ])
    }
    func setupNextButton() {
        nextButton.backgroundColor = UIColor(Color.buttonsColor)
        nextButton.shadow(UIColor(Color.buttonsColor))
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .verdanaLight
        nextButton.constrainWidth(constant: 150)
        nextButton.layer.cornerRadius = 8
    }
    func setupPreviousButton() {
        previousButton.backgroundColor = .tertiarySystemBackground
        previousButton.setTitle("Previous", for: .normal)
        previousButton.titleLabel?.font = .verdanaLight
        previousButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        previousButton.constrainWidth(constant: 150)
        previousButton.layer.cornerRadius = 8
        previousButton.layer.borderWidth = 1.5
        previousButton.layer.borderColor = UIColor(Color.buttonsColor).cgColor
    }
    func setupImage() {
        logo.image = #imageLiteral(resourceName: "Logo")
        logo.constrainWidth(constant: 87)
        logo.constrainHeight(constant: 87)
        logo.layer.cornerRadius = 12
        logo.clipsToBounds = true
    }
    func setTitle() {
        firstMessage.text = "Complete the information"
        firstMessage.font = .verdanaTitle
        firstMessage.textColor = UIColor(Color.titlesColor)
    }
    func setMessage() {
        message.text = "Bring the best service to you"
        message.font = .verdanaSmall
        message.textColor = .systemGray
    }
    func setSecondeMessage() {
        secondeMessage.text = "Last step 😄"
        secondeMessage.font = .verdanaLight
        secondeMessage.textColor = .systemGray
    }
    func setupComponents() {
        
        setupImage()
        setMessage()
        setTitle()
        setSecondeMessage()
        setFullNameContainer()
        setLivingContainer()
        setSkillsContainer()
        setPasswordContainer()
        setupNextButton()
        setupPreviousButton()
        dismissKeyBoard()
        setActions()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
   
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        setupComponents()
        
        let stack = VerticalStackView(arrangedSubviews: [logo,message,firstMessage,secondeMessage],spacing: 15)
        stack.alignment = .center
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonStack = HStackView(arrangedSubviews: [previousButton,nextButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        let vStack = VerticalStackView(arrangedSubviews: [stack,fullNameContainer,livingContainer,skillsContainer,passwordContainer,buttonStack], spacing: 25)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func keyboardWillChange(notification : Notification) {
        print("Keyboard will show : \(notification.name.rawValue)")
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect
        } else {
            view.frame.origin.y = .zero
        }
        
    }
}
struct HandymanInformationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: HandymanInformationViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct HandymanInformationViewController_Previews: PreviewProvider {
    static var previews: some View {
        HandymanInformationView()
            .edgesIgnoringSafeArea(.all)
    }
}
