//
//  EditProfileViewController.swift
//  Bricol
//
//  Created by mac on 1/5/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class EditProfileViewController: UIViewController {
    
    private let saveButton     = UIButton(type : .system)
    private let changeButton = UIButton(type : .system)
    private let personalButton = UIButton(type : .system)
    private let professionalButton = UIButton(type : .system)

    private let picture        = UIImageView(image : #imageLiteral(resourceName: "jamal"))
    private let pictureCircle  = UIView()
    private let titleLabel     = UILabel(text: "Information", font: .verdanaTitle, textColor: .titlesColor)
    private let line           = UIView(.systemGreen)
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
}
//MARK: Setup Firebase
extension EditProfileViewController {
    func uploadProfilePicture() {
        let storagePath = Storage.storage()
        let imageReference = storagePath.reference().child("profilePicture")
        let metaData = StorageMetadata()
        
        let compression : CGFloat = 0.75
        guard
            let userId = Auth.auth().currentUser?.uid,
            let phoneNumber = Auth.auth().currentUser?.phoneNumber
        else { return }
        
        guard let imageData = picture.image?.jpegData(compressionQuality: compression) else { return }

        let imagesPaths : String = "\(phoneNumber).jpg"
        let imageRef = imageReference.child(imagesPaths)
        
        imageRef.putData(imageData, metadata: metaData) { (storage, error) in
            if let error = error {
                print("Failed To upload  Image reason : ",error.localizedDescription)
                return
            }
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed to Dwonload URL reason : ",error.localizedDescription)
                    return
                }
                
                guard let imageURL = url?.absoluteString else {return}
                
                let values : [String : Any] = ["pictureProfile":imageURL]
                let db = Firestore.firestore()
                db.collection(DB_Keys.usersCollectionKey).document(userId).setData(values, merge: true) { (error) in
                    if let error = error {
                        print("Failed to marge data reason : ",error.localizedDescription)
                        return
                    }
                    Alert.showInteractiveAlert(self, with: "Image add successfully  ", and: "check out you New Image ✅")
                }
            }
        }
    }
}
private extension EditProfileViewController {
    @objc func handleSave() {
        uploadProfilePicture()
    }
    func setAction() {
        changeButton.addTarget(self, action: #selector(handlePickerImage), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    func setupProfessionalButton() {
        professionalButton.backgroundColor = UIColor(Color.buttonsColor)
        professionalButton.shadow(UIColor(Color.buttonsColor))
        professionalButton.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.next)!, string: "Professional", color: .label, imageAlignment: 1, segFont : .verdanaTitle), for: .normal)
        professionalButton.titleLabel?.font = .verdanaMedium
        professionalButton.constrainWidth(constant: 180)
        professionalButton.layer.cornerRadius = 8
    }
    func setupPersonalButton() {
        personalButton.backgroundColor = UIColor(Color.buttonsColor)
        personalButton.shadow(UIColor(Color.buttonsColor))
        personalButton.setImage(UIImage.textEmbededImage(image: UIImage(systemName: SFSymbols.next)!, string: "Personal", color: .label, imageAlignment: 1, segFont : .verdanaTitle), for: .normal)
        personalButton.titleLabel?.font = .verdanaMedium
        personalButton.constrainWidth(constant: 150)
        personalButton.layer.cornerRadius = 8
    }
    func setupNextButton() {
        saveButton.backgroundColor = UIColor(Color.buttonsColor)
        saveButton.shadow(UIColor(Color.buttonsColor))
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .verdanaLight
        saveButton.constrainWidth(constant: 100)
        saveButton.layer.cornerRadius = 8
    }
    func setupPreviousButton() {
        changeButton.backgroundColor = .tertiarySystemBackground
        changeButton.setTitle("change", for: .normal)
        changeButton.titleLabel?.font = .verdanaLight
        changeButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        changeButton.constrainWidth(constant: 100)
        changeButton.layer.cornerRadius = 8
        changeButton.layer.borderWidth = 1.5
        changeButton.layer.borderColor = UIColor(Color.buttonsColor).cgColor
    }
    func creatUI() {
        setAction()
        setupNextButton()
        setupPreviousButton()
        setupPersonalButton()
        setupProfessionalButton()
        
        let size : CGFloat = 115
        picture.contentMode = .scaleAspectFill
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = size / 2
        pictureCircle.shadow()
        pictureCircle.addSubview(picture)
        picture.fillSuperview()
        
        let hStackButton = HStackView(arrangedSubviews: [saveButton,UIView(),changeButton], spacing: 5)
        hStackButton.distribution = .fillEqually
        let hStackPicture = HStackView(arrangedSubviews: [UIView(),pictureCircle,UIView()], spacing: 5)
        hStackPicture.distribution = .equalCentering
        let vStackEditeButton = HStackView(arrangedSubviews: [personalButton,professionalButton], spacing: 10)
        vStackEditeButton.distribution = .equalCentering
        let vStackTop = VerticalStackView(arrangedSubviews: [hStackPicture,hStackButton,line,vStackEditeButton], spacing: 20)
        view.addSubview(vStackTop)
        
        vStackTop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStackTop.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            vStackTop.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
        ])
    }
}
//MARK: UIIMAGEPICKERVIEW
extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func handlePickerImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imgaeEdit = info[.editedImage] as? UIImage else  { return }
        picture.image = imgaeEdit
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("HERE")
        dismiss(animated: true)
    }
}
struct EditProfileView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = EditProfileViewController()
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
}

struct EditProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .edgesIgnoringSafeArea(.all)
    }
}
