//
//  EditePersonalInformationViewController.swift
//  Bricol
//
//  Created by mac on 1/12/21.
//

import SwiftUI

class EditePersonalInformationViewController: UIViewController {
    private let titleLabel     = UILabel()
    private let skillTitleLabel     = UILabel()
    private let saveButton   = UIButton(type : .system)
    private let cancelButton = UIButton(type : .system)
    private let describeText   = UITextView()
    private let texView = UIView()
    private let icon          = UILabel()
    private let skill     = UITextField()
    private let line          = UIView(.gray)

    let skills = MountainsController().generateMountains()
    var titles : [String] = []
    var pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
extension EditePersonalInformationViewController: UITextViewDelegate {
    @objc func handlePrevious() {
        dismiss(animated: true)
    }
    
    func setActions() {
        cancelButton.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
//        posterButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
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
        describeText.text = "Tell us More about you as Handyman"
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
struct EditePersonalInformationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = EditePersonalInformationViewController()
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
