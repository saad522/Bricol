//
//  MoreInformationViewController.swift
//  Bricol
//
//  Created by mac on 12/21/20.
//

import SwiftUI

class MoreInformationViewController: UIViewController {
    
    private let titleLabel     = UILabel()
    private let messageLabel   = UILabel()
    private let posterButton   = UIButton(type : .system)
    private let previousButton = UIButton(type : .system)
    private let describeText   = UITextView()
    
    private let texView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}

private extension MoreInformationViewController {
    
    @objc func handlePrevious() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleNext() {
       dismiss(animated: true)
    }
    func setActions() {
        previousButton.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        posterButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    func setupDescribeText() {
        //Text
        
        texView.constrainHeight(constant: 200)
        texView.constrainWidth(constant: 150)
        texView.addSubview(describeText)
        describeText.fillSuperview()
        texView.layer.cornerRadius = 12
        texView.shadow()
        texView.backgroundColor = .tertiarySystemFill
        describeText.text = "Give us More Infotmation about your the Problem you have"
        describeText.font = .verdanaLight
        describeText.textColor = .systemGray
        describeText.constrainWidth(constant: 150)
        describeText.constrainHeight(constant: 200)
        describeText.layer.cornerRadius = 12
        describeText.delegate = self
        
    }
    
    func setupNextButton() {
        posterButton.backgroundColor = UIColor(Color.buttonsColor)
        posterButton.shadow(UIColor(Color.buttonsColor))
        posterButton.setTitle("Poster", for: .normal)
        posterButton.titleLabel?.font = .verdanaLight
        posterButton.constrainWidth(constant: 150)
        posterButton.layer.cornerRadius = 8
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
        titleLabel.text = "Plus d'information"
        titleLabel.font = .verdana
        titleLabel.textColor = UIColor(Color.titlesColor)
        titleLabel.textAlignment = .center
    }
    func setupMesaageLabel() {
        messageLabel.text = "Dernière Étape"
        messageLabel.font = .verdanaLight
        messageLabel.textColor = .systemGray
        messageLabel.textAlignment = .center
    }
    func setComponents() {
        setupTitle()
        setupNextButton()
        setupPreviousButton()
        setActions()
        setupMesaageLabel()
        setupDescribeText()
        dismissKeyBoard()
    }
    func creatUI() {
        view.backgroundColor = .secondarySystemBackground
        setComponents()
        let buttonStack = HStackView(arrangedSubviews: [previousButton,posterButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        let vStack = VerticalStackView(arrangedSubviews: [titleLabel,messageLabel], spacing: 15)
        
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
//        let name = d
        view.addSubview(texView)
        texView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            texView.topAnchor.constraint(equalTo: vStack.bottomAnchor,constant: 15),
            texView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            texView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            buttonStack.topAnchor.constraint(equalTo: texView.bottomAnchor,constant: 35),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
            
        ])
        
    }
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    
}
extension MoreInformationViewController :  UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

        if describeText.textColor == UIColor.systemGray {
            describeText.text = ""
            describeText.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if describeText.text == "" {
            describeText.text = "Give us More Infotmation about your the Problem you have"
            describeText.textColor = UIColor.lightGray
        }
    }
}
struct MoreInformationView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = MoreInformationViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct MoreInformationViewController_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationView()
            .edgesIgnoringSafeArea(.all)
    }
}
