//
//  EditeOtherInformationViewController.swift
//  Bricol
//
//  Created by mac on 1/12/21.
//

import SwiftUI

class EditeOtherInformationViewController: UIViewController {
    private let fullNameLabel     = UILabel()
    private let livingLabel     = UILabel()
    private let saveButton   = UIButton(type : .system)
    private let cancelButton = UIButton(type : .system)
    private var fullNameContainer = UIView()
    private var fullName          = UITextField()
    private var livingContainer   = UIView()
    private var living            = UITextField()
    //UIPickeView
    var pickerView = UIPickerView()
    let cities = CityController().generateMountains()
    var titles : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
extension EditeOtherInformationViewController {
    @objc func handleCancelButton() {
        dismiss(animated: true)
    }
    func setActions() {
        cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
//        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    private func setupLivingLabel() {
        fullNameLabel.text = "Full-Name"
        fullNameLabel.font = .verdana
        fullNameLabel.textColor = UIColor(Color.titlesColor)
        fullNameLabel.textAlignment = .center
    }
    private func setupFullNameLabel() {
        livingLabel.text = "Location"
        livingLabel.font = .verdana
        livingLabel.textColor = UIColor(Color.titlesColor)
        livingLabel.textAlignment = .center
    }
   private func setFullNameContainer() {
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
    private func setComponents() {
        setupLivingLabel()
        setupFullNameLabel()
        setupNextButton()
        setupPreviousButton()
        dismissKeyBoard()
        setupPickeView()
        setLivingContainer()
        setFullNameContainer()
        setActions()
    }
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        setComponents()
        let buttonStack = HStackView(arrangedSubviews: [cancelButton,saveButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        [fullNameLabel,livingLabel].forEach({$0.textAlignment = .left})
        let vStack = VerticalStackView(arrangedSubviews: [fullNameLabel,fullNameContainer,livingLabel,livingContainer,buttonStack], spacing: 5)
        vStack.setCustomSpacing(15, after: fullNameLabel)
        vStack.setCustomSpacing(25, after: fullNameContainer)
        vStack.setCustomSpacing(15, after: livingLabel)
        vStack.setCustomSpacing(45, after: livingContainer)
        
        view.addSubview(vStack)
        vStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(allInset: 15))
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
//MARK: SetUp UIPickeView
extension EditeOtherInformationViewController : PickerConfiguer {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cities.forEach({titles.append($0.name)})
        living.text = titles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cities.forEach({titles.append($0.name)})
        return titles[row]
    }
    fileprivate func setupPickeView() {
        pickerView.delegate    = self
        pickerView.dataSource  = self
        living.inputView = pickerView
    }
}
struct EditeOtherInformationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = EditeOtherInformationViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct EditeOtherInformationViewController_Previews: PreviewProvider {
    static var previews: some View {
        EditeOtherInformationView()
            .edgesIgnoringSafeArea(.all)
    }
}
