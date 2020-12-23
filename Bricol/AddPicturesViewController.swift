//
//  AddPicturesViewController.swift
//  Bricol
//
//  Created by mac on 12/21/20.
//

import SwiftUI

class AddPicturesViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let nextButton = UIButton(type : .system)
    private var previousButton    = UIButton(type : .system)
    
    private let imageOne   = UIImageView()
    private let imageTwo   = UIImageView()
    private let imageTree  = UIImageView()
    private let imageFour  = UIImageView()
    private let imageFive  = UIImageView()
    
    private let buttonOne   = UIButton(type : .system)
    private let buttonTwo   = UIButton(type : .system)
    private let buttonTree  = UIButton(type : .system)
    private let buttonFour  = UIButton(type : .system)
    private let buttonFive  = UIButton(type : .system)
    
    private let addOneLabel = UILabel()
    private let addTowLabel = UILabel()
    private let addTreeLabel = UILabel()
    private let addFourLabel = UILabel()
    private let addFiveLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
private extension AddPicturesViewController {
    @objc func handlePrevious() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleNext() {
        navigationController?.pushViewController(AddBudgetViewController(), animated: true)
    }
    func setActions() {
        previousButton.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    func setupViewImages() {
        
        [addOneLabel,addTowLabel,addTreeLabel,addFourLabel,addFiveLabel].forEach({$0.text = "Add One"})
        [buttonOne,buttonTwo,buttonTree,buttonFour,buttonFive].forEach { (button) in
            button.setImage(UIImage(systemName: SFSymbols.addImage), for: .normal)
            button.tintColor = .label
        }
        [imageOne,imageTwo,imageTree,imageFour,imageFive].forEach { (image) in
            image.constrainWidth(constant: 150)
            image.constrainHeight(constant: 150)
            image.shadow()
            image.backgroundColor = .white
        }
        let vStackOne = VerticalStackView(arrangedSubviews: [buttonOne,addOneLabel], spacing: 5)
        
        let vStackTwo = VerticalStackView(arrangedSubviews: [buttonTwo,addTowLabel], spacing: 5)
        
        let vStackTree = VerticalStackView(arrangedSubviews: [buttonTree,addTreeLabel], spacing: 5)
        
        let vStackFour = VerticalStackView(arrangedSubviews: [buttonFour,addFourLabel], spacing: 5)
        
        let vStackFive = VerticalStackView(arrangedSubviews: [buttonFive,addFiveLabel], spacing: 5)
        buttonOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickerImageOne)))
        buttonTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickerImageTwo)))
        buttonTree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickerImageTree)))
        buttonFour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickerImageFour)))
        [imageOne,imageTwo,imageTree,imageFour,imageFive].forEach({$0.isUserInteractionEnabled = true})
        imageOne.addSubview(vStackOne)
        imageTwo.addSubview(vStackTwo)
        imageTree.addSubview(vStackTree)
        imageFour.addSubview(vStackFour)
        imageFive.addSubview(vStackFive)
        [vStackOne,vStackTwo,vStackTree,vStackFour,vStackFive].forEach({$0.centerInSuperview()})
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
        titleLabel.text = "Ajouter des images"
        titleLabel.font = .verdana
        titleLabel.textColor = UIColor(Color.titlesColor)
        titleLabel.textAlignment = .center
    }
    func setComponents() {
        setupTitle()
        setupNextButton()
        setupViewImages()
        setupPreviousButton()
        setActions()
    }
    
    func creatUI() {
        setComponents()
        navigationController?.isNavigationBarHidden = true
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(allInset: 15))
        view.backgroundColor = .secondarySystemBackground
        let hStackOne = HStackView(arrangedSubviews: [imageOne,imageTwo], spacing: 15)
        let hStackTwo = HStackView(arrangedSubviews: [imageTree,imageFour], spacing: 15)
        let buttonStack = HStackView(arrangedSubviews: [previousButton,nextButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        let vStack = VerticalStackView(arrangedSubviews: [hStackOne,hStackTwo,buttonStack], spacing: 25)
        
        view.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
          
        ])
    }
}
//MARK: UIIMAGEPICKERVIEW
extension AddPicturesViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func handlePickerImageOne() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    @objc func handlePickerImageTwo() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    @objc func handlePickerImageTree() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    @objc func handlePickerImageFour() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imgaeEdit = info[.editedImage] as? UIImage else  { return }
        
        if imageOne.image == nil {
            buttonOne.isHidden = true
            addOneLabel.isHidden = true
            imageOne.image = imgaeEdit
        } else if imageTwo.image == nil {
            buttonTwo.isHidden = true
            addTowLabel.isHidden = true
            imageTwo.image = imgaeEdit
        } else if imageTree.image == nil {
            buttonTree.isHidden = true
            addTreeLabel.isHidden = true
            imageTree.image = imgaeEdit
        } else {
            buttonFour.isHidden = true
            addFourLabel.isHidden = true
            imageFour.image = imgaeEdit
        }
        
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("HERE")
        dismiss(animated: true)
    }
}
struct AddPicturesView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AddPicturesViewController()
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
}

struct AddPicturesViewController_Previews: PreviewProvider {
    static var previews: some View {
        AddPicturesView()
            .edgesIgnoringSafeArea(.all)
    }
}
