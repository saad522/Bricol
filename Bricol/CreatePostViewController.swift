//
//  CreatePostViewController.swift
//  Bricol
//
//  Created by mac on 12/21/20.
//

import SwiftUI

class CreatePostViewController: UIViewController {
    
    private let design        = UIImageView()
    private let dismissButton = UIButton(type : .system)
    private let titleLabel    = UILabel()
    private let textField     = UITextField()
    private let icon          = UILabel()
    private let line          = UIView(.gray)
    private let nextButton    = UIButton(type : .system)
    let skills = MountainsController().generateMountains()
    var titles : [String] = []
    var pickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
//MARK: SetUp UIPickeView
typealias PickerConfiguer = UIPickerViewDelegate & UIPickerViewDataSource

extension CreatePostViewController :  PickerConfiguer {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skills.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        skills.forEach({titles.append($0.name)})
        textField.text = titles[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        skills.forEach({titles.append($0.name)})
        return titles[row]
    }
    fileprivate func setupPickeView() {
        pickerView.delegate    = self
        pickerView.dataSource  = self
        textField.inputView = pickerView
    }
}
private extension CreatePostViewController {
    @objc func handlePrevious() {
        guard let handymanSelected = textField.text else { return }
        UserDefaults.standard.set(handymanSelected, forKey: "handymanSelected")
        
        navigationController?.pushViewController(AddPicturesViewController(), animated: true)
    }
    func setActions() {
        nextButton.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
    }
    func setupNextButton() {
        nextButton.backgroundColor = UIColor(Color.buttonsColor)
        nextButton.shadow(UIColor(Color.buttonsColor))
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .verdana
        nextButton.constrainWidth(constant: 150)
        nextButton.layer.cornerRadius = 8
    }
    func setupTextField() {
        //Text
        textField.constrainWidth(constant: 270)
        textField.constrainHeight(constant: 59)
        textField.borderStyle  = .none
        textField.font = .verdanaLight
        textField.attributedPlaceholder = NSAttributedString(string: "Plombier", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        //Label icon 👨🏻‍🔧
        icon.text = "👨🏻‍🔧"

    }
    func setupTitle() {
        titleLabel.text = "Je recherche un"
        titleLabel.font = .verdana
        titleLabel.textColor = UIColor(Color.titlesColor)
        titleLabel.textAlignment = .center
    }
    func setupDesign() {
        design.image = #imageLiteral(resourceName: "undraw_coffee_break_h3uu")
        design.constrainHeight(constant: 223)
    }
    func setupDismissButton() {
        dismissButton.setImage(UIImage(systemName: SFSymbols.dismissPost,withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .large)), for: .normal)
        dismissButton.tintColor = .label
        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
    }
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func setComponents() {
        setupDismissButton()
        setupDesign()
        setupTitle()
        setupTextField()
        setupNextButton()
        dismissKeyBoard()
        setActions()
        setupPickeView()
    }
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        setComponents()
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(allInset: 5))
        
        let vStack = VerticalStackView(arrangedSubviews: [design,titleLabel], spacing: 25)
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        let hSatck = HStackView(arrangedSubviews: [icon,textField,UIView()], spacing: 5)
        let vStackLine = VerticalStackView(arrangedSubviews: [hSatck,line], spacing: 10)
        let vStackMain = VerticalStackView(arrangedSubviews: [vStackLine,nextButton], spacing: 40)
        
        view.addSubview(vStackMain)
        vStackMain.translatesAutoresizingMaskIntoConstraints = false
 
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 0),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1),
            vStackMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            vStackMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            vStackMain.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 25)
        ])
    }
}
struct CreatePostView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CreatePostViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct CreatePostViewController_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .edgesIgnoringSafeArea(.all)
    }
}
