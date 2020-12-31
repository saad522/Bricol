//
//  LookingForViewController.swift
//  Bricol
//
//  Created by mac on 12/19/20.
//

import SwiftUI

class LookingForViewController: UIViewController {
    
    //MARK: Properties
    var homeViewController : HomeViewControllert?

    private var logo              = UIImageView()
    private var name              = UILabel()
    private var message           = UILabel()
    private var cardClient        = CardView(image: #imageLiteral(resourceName: "TargetCustomer"), name: "Client", sizes: .init(width: 146, height: 134))
    private var cardHandyman      = CardView(image: #imageLiteral(resourceName: "Handyman3"), name: "Bricoleur",sizes: .init(width: 146, height: 134))
    private var nextButton        = UIButton(type : .system)
    private var previousButton    = UIButton(type : .system)
    private var isClientSelected : Bool = false
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}


private extension LookingForViewController {
    @objc func handleCardClient(gesture : UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            isClientSelected = true
            print("Card Client Selected")
            cardClient.shadow(.systemGreen)
            cardClient.backgroundColor = UIColor(Color.buttonsColor)
            cardClient.label.textColor = .white
            cardHandyman.backgroundColor = .systemBackground
            cardHandyman.shadow(.clear)
            cardHandyman.label.textColor = .systemGray
            
        }
    }
    @objc func handleCardHandyman(gesture : UITapGestureRecognizer) {
        if gesture.state == .ended {
            print("Handyman  Selected")
            isClientSelected = false
            cardHandyman.shadow(.systemGreen)
            cardHandyman.backgroundColor = UIColor(Color.buttonsColor)
            cardHandyman.label.textColor = .white
            cardClient.backgroundColor = .systemBackground
            cardClient.shadow(.clear)
            cardClient.label.textColor = .systemGray
        }
        
    }
    func setCardsTapGestures() {
        let tapClient = UITapGestureRecognizer(target: self, action: #selector(handleCardClient))
        
        cardClient.addGestureRecognizer(tapClient)
        
        let tapHandyman = UITapGestureRecognizer(target: self, action: #selector(handleCardHandyman))
        
        cardHandyman.addGestureRecognizer(tapHandyman)
    }
    @objc func handelPrevious() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleNext() {
        if isClientSelected {
            let handyManInformationViewController = HandymanInformationViewController()
            handyManInformationViewController.homeViewController = homeViewController
            navigationController?.pushViewController(HandymanInformationViewController(), animated: true)
        } else {
            let clinetInformationViewController = ClientInformationViewController()
            clinetInformationViewController.homeViewController = homeViewController
            navigationController?.pushViewController(clinetInformationViewController, animated: true)
        }
        
    }
    func setActions() {
        previousButton.addTarget(self, action: #selector(handelPrevious), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    func setupImage() {
        logo.image = #imageLiteral(resourceName: "Logo")
        logo.constrainWidth(constant: 87)
        logo.constrainHeight(constant: 87)
        logo.layer.cornerRadius = 12
        logo.clipsToBounds = true
    }
    func setTitle() {
        name.text = "Are you Looking For a Bricoleur or Client?"
        name.font = .verdanaTitle
        name.textColor = UIColor(Color.titlesColor)
        name.textAlignment = .center
        name.numberOfLines = 2
    }
    func setMessage() {
        message.text = "Bring the best service to you"
        message.font = .verdanaLight
        message.textColor = .systemGray
    }
    func setupComponents() {
        setupImage()
        setMessage()
        setTitle()
        setCardsTapGestures()
        setupPreviousButton()
        setupNextButton()
        setActions()
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
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        setupComponents()
        let stack = VerticalStackView(arrangedSubviews: [logo,message,name],spacing: 15)
        stack.alignment = .center
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        let hStack = HStackView(arrangedSubviews: [cardClient,cardHandyman], spacing: 10)
        hStack.distribution = .equalCentering
        view.addSubview(hStack)
        
        hStack.anchor(top: stack.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(allInset: 20))
        
        let buttonStack = HStackView(arrangedSubviews: [nextButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25),
            buttonStack.topAnchor.constraint(equalTo: hStack.safeAreaLayoutGuide.bottomAnchor, constant: 40)
        ])
    }
}
struct LookingForView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: LookingForViewController())
        return controller
     }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct LookingForViewController_Previews: PreviewProvider {
    static var previews: some View {
        LookingForView()
            .edgesIgnoringSafeArea(.all)
    }
}
