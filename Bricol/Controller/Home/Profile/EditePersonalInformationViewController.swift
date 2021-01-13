//
//  EditePersonalInformationViewController.swift
//  Bricol
//
//  Created by mac on 1/12/21.
//

import SwiftUI
import Firebase

class EditePersonalInformationViewController: UIViewController {
    //MARK: Properties
    var values : [String:Any] = [:]
    init(values : [String:Any] = [:]) {
        self.values = values
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let titleLabel      = UILabel()
    private let skillTitleLabel = UILabel()
    private let saveButton      = UIButton(type : .system)
    private let cancelButton    = UIButton(type : .system)
    private let describeText    = UITextView()
    private let texView         = UIView()
    private let icon            = UILabel()
    private let skill           = UITextField()
    private let line            = UIView(.gray)

    let skills = MountainsController().generateMountains()
    var titles : [String] = []
    var pickerView = UIPickerView()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
//MARK: Setup Firebase
extension EditePersonalInformationViewController {
    func updateInformation() {
        guard
            let aboutMe = describeText.text,
            let metier = skill.text,
            let documentID = Auth.auth().currentUser?.uid
        else { return }
        
        values["aboutMe"] = aboutMe
        values["metier"]  = metier
        let db = Firestore.firestore()
        db.collection(DB_Keys.usersCollectionKey).document(documentID).setData(values, merge: true) { (error) in
            if let error = error {
                print("Failed To Merge user Data reason : ",error.localizedDescription)
                Alert.showInteractiveAlert(self, with: "Update Failed", and: "Something wrong : \(error.localizedDescription)")
                return
            }
            Alert.showInteractiveAlert(self, with: "Update with success", and: "All your information is updated ✅")
            print("DEBUG: All Merge it ⚠️")
        }
    }
}
extension EditePersonalInformationViewController: UITextViewDelegate {
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    @objc func handleUpdate() {
        updateInformation()
    }
    func setActions() {
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
    }
    private func setValues() {
        describeText.text = values["aboutMe"] as? String
        skill.text        = values["metier"]  as? String
    }
    private  func setupNextButton() {
        saveButton.backgroundColor = UIColor(Color.buttonsColor)
        saveButton.shadow(UIColor(Color.buttonsColor))
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .verdanaLight
        saveButton.constrainWidth(constant: 150)
        saveButton.layer.cornerRadius = 8
    }
    private  func setupPreviousButton() {
        cancelButton.backgroundColor = .tertiarySystemBackground
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = .verdanaLight
        cancelButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        cancelButton.constrainWidth(constant: 150)
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1.5
        cancelButton.layer.borderColor = UIColor(Color.buttonsColor).cgColor
    }
    private func setupTitle() {
        titleLabel.text = "About me"
        titleLabel.font = .verdana
        titleLabel.textColor = UIColor(Color.titlesColor)
        titleLabel.textAlignment = .center
    }
    private func setupSkillTitle() {
        skillTitleLabel.text = "Change the métier"
        skillTitleLabel.font = .verdana
        skillTitleLabel.textColor = UIColor(Color.titlesColor)
        skillTitleLabel.textAlignment = .center
    }
    private func setupDescribeText() {
        //Text
        
        texView.constrainHeight(constant: 200)
        texView.constrainWidth(constant: 150)
        texView.addSubview(describeText)
        describeText.fillSuperview()
        texView.layer.cornerRadius = 12
        texView.shadow()
        texView.backgroundColor = .tertiarySystemFill
        describeText.text = values["aboutMe"]  as? String
        describeText.font = .verdanaLight
        describeText.textColor = .systemGray
        describeText.constrainWidth(constant: 150)
        describeText.constrainHeight(constant: 200)
        describeText.layer.cornerRadius = 12
        describeText.delegate = self
        
    }
    func setupTextField() {
        //Text
        skill.constrainWidth(constant: 270)
        skill.constrainHeight(constant: 59)
        skill.borderStyle  = .none
        skill.font = .verdanaLight
        skill.attributedPlaceholder = NSAttributedString(string: "Plombier", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        //Label icon 👨🏻‍🔧
        icon.text = "👨🏻‍🔧"

    }
    private func setComponents() {
        setValues()
        setupTextField()
        setupTitle()
        setupNextButton()
        setupPreviousButton()
        setActions()
        setupDescribeText()
        dismissKeyBoard()
        setupSkillTitle()
        setupPickeView()
    }
    private  func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        setComponents()
        let hSatck = HStackView(arrangedSubviews: [icon,skill,UIView()], spacing: 5)
        let buttonStack = HStackView(arrangedSubviews: [cancelButton,saveButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        titleLabel.textAlignment = .left
        skillTitleLabel.textAlignment = .left
        let vStackLine = VerticalStackView(arrangedSubviews: [skillTitleLabel,hSatck,line,titleLabel,texView,buttonStack], spacing: 0)
        view.addSubview(vStackLine)
        vStackLine.setCustomSpacing(30, after: line)
        vStackLine.setCustomSpacing(15, after: titleLabel)
        vStackLine.setCustomSpacing(35, after: texView)
        vStackLine.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(allInset: 15))
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
//MARK: SetUp UIPickeView

extension EditePersonalInformationViewController :  PickerConfiguer {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skills.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        skills.forEach({titles.append($0.name)})
        skill.text = titles[row]
        print(" Selected  Row : ",titles[row])
        print(" Selected Text : ",skill.text!)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        skills.forEach({titles.append($0.name)})
        return titles[row]
    }
    fileprivate func setupPickeView() {
        pickerView.delegate    = self
        pickerView.dataSource  = self
        skill.inputView = pickerView
    }
}
extension EditePersonalInformationViewController {
    func textViewDidBeginEditing(_ textView: UITextView) {

        if describeText.textColor == UIColor.systemGray {
            describeText.text = ""
            describeText.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if describeText.text == "" {
            describeText.text = "Tell us more about you"
            describeText.textColor = UIColor.lightGray
        }
    }
}
struct EditePersonalInformationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = EditePersonalInformationViewController(values: [:])
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
   
}

struct EditePersonalInformationViewController_Previews: PreviewProvider {
    static var previews: some View {
        EditePersonalInformationView()
            .edgesIgnoringSafeArea(.all)
    }
}
