//
//  AddBudgetViewController.swift
//  Bricol
//
//  Created by mac on 12/21/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AddBudgetViewController: UIViewController {
    let values : [String : Any]?
    init(values : [String : Any]?) {
        self.values = values
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let titleLabel      = UILabel()
    private let nextButton      = UIButton(type : .system)
    private let previousButton  = UIButton(type : .system)
    private let maxContainer    = UIView()
    private let maxPrice        = UITextField()
    private let minContainer    = UIView()
    private let minPrice        = UITextField()
    private let maxLabel        = UILabel()
    private let minLabel        = UILabel()
    private let negotiableLabel = UILabel()
    private let yesLabel        = UILabel()
    private let notLabel        = UILabel()
    private let yesNegotiable   = UIButton(with: SFSymbols.selected)
    private let notNegotiable   = UIButton(with: SFSymbols.selected)
    private var buttons         = [UIButton]()
    private var isNegotiable    : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
//MARK: setuo Firebase
extension AddBudgetViewController {
    @objc func handleNext() {
        guard var data = values else { return  }
        guard
            let max = maxPrice.text,
            let min = minPrice.text
        else { return  }
        data["Max"] = max
        data["Min"] = min
        data["isNegotiable"] = isNegotiable
        let moreInformationViewController = MoreInformationViewController(values: data)
        navigationController?.pushViewController(moreInformationViewController, animated: true)
    }

}
private extension AddBudgetViewController {
    func buttonAction(sender: UIButton!){
        for button in buttons {
            button.isSelected = false
            button.tintColor  = .label
        }
        sender.isSelected = true
        // you may need to know which button to trigger some action
        // let buttonIndex = buttons.indexOf(sender)
        sender.tintColor = UIColor(Color.buttonsColor)
    }
    func setUpNegotiable() {
        buttons.append(yesNegotiable)
        buttons.append(notNegotiable)
        negotiableLabel.text = "Negotiable"
        negotiableLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        negotiableLabel.textColor = .systemGray
        
        yesLabel.text = "Yes"
        yesLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        yesLabel.textColor = .label
        
        notLabel.text = "No"
        notLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        notLabel.textColor = .label
        
    }
    func setupMinContainer() {
        //Container
        minContainer.backgroundColor = .tertiarySystemBackground
        minContainer.layer.cornerRadius = 12
        minContainer.constrainHeight(constant: 60)
        minContainer.shadow()
        
        //Text
        minPrice.constrainWidth(constant: 270)
        minPrice.constrainHeight(constant: 59)
        minPrice.borderStyle  = .none
        minPrice.keyboardType = .numberPad
        minPrice.font = .verdanaLight
        minPrice.attributedPlaceholder = NSAttributedString(string: "900 DH", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        minContainer.addSubview(minPrice)
        minPrice.translatesAutoresizingMaskIntoConstraints = false
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            minPrice.leadingAnchor.constraint(equalTo: minContainer.leadingAnchor,constant: 16),
            minPrice.centerYAnchor.constraint(equalTo: minContainer.centerYAnchor),
            
            
        ])
        minLabel.text = "Min"
        minLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        minLabel.textColor = .systemGray
        
    }
    func setupMaxContainer() {
        //Container
        maxContainer.backgroundColor = .tertiarySystemBackground
        maxContainer.layer.cornerRadius = 12
        maxContainer.constrainHeight(constant: 60)
        maxContainer.shadow()
        
        //Text
        maxPrice.constrainWidth(constant: 270)
        maxPrice.constrainHeight(constant: 59)
        maxPrice.borderStyle  = .none
        maxPrice.keyboardType = .numberPad
        maxPrice.font = .verdanaLight
        maxPrice.attributedPlaceholder = NSAttributedString(string: "1200 DH", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaLight])
        maxContainer.addSubview(maxPrice)
        maxPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxPrice.leadingAnchor.constraint(equalTo: maxContainer.leadingAnchor,constant: 16),
            maxPrice.centerYAnchor.constraint(equalTo: maxContainer.centerYAnchor)
        ])
        maxLabel.text = "Max"
        maxLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        maxLabel.textColor = .systemGray
    }
    
    @objc func handlePrevious() {
        navigationController?.popViewController(animated: true)
    }
    
    func setActions() {
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        yesNegotiable.addTarget(self, action: #selector(handleYes), for: .touchUpInside)
        notNegotiable.addTarget(self, action: #selector(handleNot), for: .touchUpInside)
    }
    @objc func handleYes() {
        isNegotiable.toggle()
        buttonAction(sender: yesNegotiable)
    }
    @objc func handleNot() {
        isNegotiable.toggle()
        buttonAction(sender: notNegotiable)
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
    func setupTitle() {
        titleLabel.text = "Ajouter un budget"
        titleLabel.font = .verdana
        titleLabel.textColor = UIColor(Color.titlesColor)
        titleLabel.textAlignment = .center
    }
    func setComponents() {
        setupTitle()
        setupNextButton()
        setupPreviousButton()
        setActions()
        setupMinContainer()
        setupMaxContainer()
        setUpNegotiable()
        dismissKeyBoard()
    }
    
    func creatUI() {
        setComponents()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let vStackMin = VerticalStackView(arrangedSubviews: [minLabel,minContainer], spacing: 5)
        let vStackMax = VerticalStackView(arrangedSubviews: [maxLabel,maxContainer], spacing: 5)
        
        let buttonStack = HStackView(arrangedSubviews: [previousButton,nextButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
       
        let hstackYes = HStackView(arrangedSubviews: [yesLabel,yesNegotiable], spacing: 3)
        let hstackNo = HStackView(arrangedSubviews: [notLabel,notNegotiable], spacing: 3)
        let hStack = HStackView(arrangedSubviews: [negotiableLabel,hstackYes,hstackNo], spacing: 10)
        
        let vStack = VerticalStackView(arrangedSubviews: [vStackMin,vStackMax,hStack,buttonStack], spacing: 35)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
struct AddBudgetView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AddBudgetViewController(values: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct AddBudgetViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
            .edgesIgnoringSafeArea(.all)
    }
}
