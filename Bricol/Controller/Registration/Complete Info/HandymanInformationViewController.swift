//
//  HandymanInformationViewController.swift
//  Bricol
//
//  Created by mac on 12/19/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

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
    private var skill            = UITextField()
    private var passwordContainer = UIView()
    private var password          = UITextField()
    private var nextButton        = UIButton(type : .system)
    private var previousButton    = UIButton(type : .system)
    //UIPickeView
    var pickerViewCities = UIPickerView()
    let cities = CityController().generateMountains()
    var titlesOfCities : [String] = []
    
    let skills = MountainsController().generateMountains()
    var titles : [String] = []
    var pickerView = UIPickerView()
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
//MARK: Setup Firebase
extension HandymanInformationViewController {
    
    @objc func handleNext() {
        guard let name = fullName.text, let city = living.text, let metier = skill.text else { return }
        let isClient = 0
        let work = "0"
        let review = "0"
        let status = false
        let aboutMe = ""
        
        let values : [String:Any] = ["name":name,
                                     "city":city,
                                     "metier":metier,
                                     "isClient":isClient,
                                     "work":work,
                                     "review":review,
                                     "status":status,
                                     "aboutMe":aboutMe]
        guard let uiserID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection(DB_Keys.usersCollectionKey).document(uiserID).setData(values, merge: true) { [weak self] (error) in
            if let error = error {
                print("Failed to set Data 👎🏻 reason ",error.localizedDescription)
                
                return
            }
            print("Its's Done ✅ ")
            self?.dismiss(animated: true)
           
        }
    }
}
//MARK: SetUp UIPickeView
extension HandymanInformationViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      
        return component == 0 ? cities.count : skills.count
    }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            cities.forEach({titlesOfCities.append($0.name)})
            living.text = titlesOfCities[row]
        } else {
            skills.forEach({titles.append($0.name)})
            skill.text = titles[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            cities.forEach({titlesOfCities.append($0.name)})
            return titlesOfCities[row]
        } else {
            skills.forEach({titles.append($0.name)})
            return titles[row]
            
        }
       
    }
    fileprivate func setupPickeView() {
        pickerViewCities.delegate    = self
        pickerViewCities.dataSource  = self
        living.inputView = pickerView
        
        pickerView.delegate    = self
        pickerView.dataSource  = self
        skill.inputView = pickerView
    }
}

private extension HandymanInformationViewController {
    @objc func handlePreviousButton() {
        navigationController?.popViewController(animated: true)
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
        skill.constrainWidth(constant: 270)
        skill.constrainHeight(constant: 59)
        skill.borderStyle  = .none
        skill.font = .verdanaLight
        skill.attributedPlaceholder = NSAttributedString(string: "What’s your skills?", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        skillsContainer.addSubview(skill)
        skill.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skill.leadingAnchor.constraint(equalTo: skillsContainer.leadingAnchor,constant: 16),
            skill.centerYAnchor.constraint(equalTo: skillsContainer.centerYAnchor)
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
        setupPickeView()
        setupImage()
        setMessage()
        setTitle()
        setSecondeMessage()
        setFullNameContainer()
        setLivingContainer()
        setSkillsContainer()
//        setPasswordContainer()
        setupNextButton()
        setupPreviousButton()
        dismissKeyBoard()
        setActions()
        notificationCenter()
    }
    func notificationCenter() {
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
        
        
        let vStack = VerticalStackView(arrangedSubviews: [stack,fullNameContainer,livingContainer,skillsContainer,buttonStack], spacing: 25)
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
        if skill.isFirstResponder == true && fullName.isFirstResponder == true {
            if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
                view.frame.origin.y = -keyboardRect
            } else {
                view.frame.origin.y = .zero
            }
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
