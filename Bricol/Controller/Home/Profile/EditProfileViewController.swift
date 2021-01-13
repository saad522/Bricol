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
    var image = ""
    var values : [String:Any] = [:]
    
    private let saveButton          = UIButton(type : .system)
    private let changeButton        = UIButton(type : .system)
    private let personalButton      = UIButton(type : .system)
    private let professionalButton  = UIButton(type : .system)
    private var personalView        = UIView()
    private let personalCard        = UIView()
    private let professionalCard    = UIView()
    private let professionalView    = UIView()
    private let iconTitle           = UIImageView(SFSymbols.info,UIColor(Color.titlesColor))
    private let personalTitle       = UILabel(text: "Personal", font: .verdana, textColor: .white)
    private let professionalTitle   = UILabel(text: "Professional", font: .verdana, textColor: .white)
    private let presonalMessage     = UILabel(text: "Edit your Personal Information ", font: .systemFont(ofSize: 25, weight: .regular),numberOfLines: 2, textColor: .gray)
    private let professionalMessage = UILabel(text: "Edit your Professional information ", font: .systemFont(ofSize: 25, weight: .regular), numberOfLines: 2,textColor: .white)

    private let picture        = UIImageView()
    private let pictureCircle  = UIView()
    private let titleLabel     = UILabel(text: "Information", font: .verdana, textColor: .titlesColor)
    private let line           = UIView(.systemGreen)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        fetchuserInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchuserInfo()
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

                    ServiceDatabase.shared.fetechAllUserReviews { (result) in
                        let values : [String : Any] = ["clientPicture":imageURL]
                        switch result {
                        case .success(let ids):
                            ids.forEach { (id) in
                                db.collection(DB_Keys.reviewCollectionKey).document(id).setData(values, merge: true) { (error) in
                                    if let error = error {
                                        print("Failed To set New Image to reviews reason : ",error.localizedDescription)
                                        return
                                    }
                                    print("DEBUG: All Set 👨🏻‍🔧")
                                }
                            }
                        case .failure(let error):
                            print("Failed To Load Reviews Ids reason : ",error.localizedDescription)
                        }
                    }
                    ServiceDatabase.shared.fetchAllUserPosts { (result) in
                        switch result {
                        case .success(let ids):
                            ids.forEach { (id) in
                                db.collection(DB_Keys.postsCollectionKey).document(id).setData(values, merge: true) {  (error) in
                                    if let error = error {
                                        print("Failed to set Data Image reason : ",error.localizedDescription)
                                        return
                                    }
                                    print("DEBUG: All clear 🧭")
                                }
                            }
                        case .failure(let error):
                            print("Failed to Load Reason : ",error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    func fetchuserInfo() {
        ServiceDatabase.shared.fetchUserInfo { [weak self] (user, error) in
            if let error = error {
                print("Failed To Load User Info reason : ",error.localizedDescription)
                return
            }
            self?.values["aboutMe"] = user?.aboutMe
            self?.values["metier"]  = user?.metier
            self?.values["city"]    = user?.city
            self?.values["name"]    = user?.name
        }
    }
}
private extension EditProfileViewController {
    @objc func handleSave() {
        uploadProfilePicture()
    }
    @objc func handleProfessionButtonTapped() {
        let editePersonalInformationViewController = EditePersonalInformationViewController(values: values)
        editePersonalInformationViewController.modalPresentationStyle = .fullScreen
        present(editePersonalInformationViewController, animated: true)
    }
    @objc func handlePersonalButtonTapped() {
        let editeOtherInformationViewController = EditeOtherInformationViewController(values: values)
        editeOtherInformationViewController.modalPresentationStyle = .fullScreen
        present(editeOtherInformationViewController, animated: true)
    }
    func setAction() {
        changeButton.addTarget(self, action: #selector(handlePickerImage), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        professionalButton.addTarget(self, action: #selector(handleProfessionButtonTapped), for: .touchUpInside)
        personalButton.addTarget(self, action: #selector(handlePersonalButtonTapped), for: .touchUpInside)
    }
    func setupProfessionalCard() {
        professionalCard.constrainWidth(constant: view.frame.size.width - 25)
        professionalCard.constrainHeight(constant: 150)
        professionalCard.shadow()
        professionalCard.addSubview(professionalView)
        professionalView.fillSuperview()
        professionalView.frame.size = CGSize(width: view.frame.size.width - 25, height: 150)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(Color.buttonsColor).cgColor, UIColor.init(white: 0.8, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = personalView.bounds
        gradientLayer.cornerRadius = 12
        professionalView.clipsToBounds = false
        professionalView.layer.insertSublayer(gradientLayer, at: 0)
        presonalMessage.textColor = .init(white: 1, alpha: 0.8)
        professionalView.layer.cornerRadius = 12
        professionalButton.setTitle(" Edit ", for: .normal)
        professionalButton.backgroundColor = .systemBackground
        professionalButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        professionalButton.layer.cornerRadius = 5
        professionalButton.shadow()
        professionalButton.setTitleColor(.label, for: .normal)
        professionalButton.constrainHeight(constant: 35)
        professionalButton.constrainWidth(constant: 100)
  
        let hStack = HStackView(arrangedSubviews: [UIView(),professionalButton], spacing: 10)
        hStack.distribution = .equalSpacing
        let vStack = VerticalStackView(arrangedSubviews: [professionalTitle,professionalMessage,hStack], spacing: 10)
        professionalView.addSubview(vStack)
        vStack.fillSuperview(padding: .init(allInset: 10))
    
    }
    
    func setupPersonalCard() {
        personalCard.constrainWidth(constant: view.frame.size.width - 25)
        personalCard.constrainHeight(constant: 150)
        personalCard.shadow()
        personalCard.addSubview(personalView)
        personalView.fillSuperview()
        personalView.frame.size = CGSize(width: view.frame.size.width - 25, height: 150)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.init(white: 0.8, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = personalView.bounds
        gradientLayer.cornerRadius = 12
        personalView.clipsToBounds = false
        personalView.layer.insertSublayer(gradientLayer, at: 0)
        presonalMessage.textColor = .init(white: 1, alpha: 0.8)
        personalView.layer.cornerRadius = 12
        personalButton.setTitle(" Edit ", for: .normal)
        personalButton.backgroundColor = .systemBackground
        personalButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        personalButton.layer.cornerRadius = 5
        personalButton.shadow()
        personalButton.setTitleColor(.label, for: .normal)
        personalButton.constrainHeight(constant: 35)
        personalButton.constrainWidth(constant: 100)
        
        
       

        let hStack = HStackView(arrangedSubviews: [UIView(),personalButton], spacing: 10)
        hStack.distribution = .equalSpacing
        let vStack = VerticalStackView(arrangedSubviews: [personalTitle,presonalMessage,hStack], spacing: 10)
        personalView.addSubview(vStack)
        vStack.fillSuperview(padding: .init(allInset: 10))
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
        setupPersonalCard()
        let isClient = UserDefaults.standard.integer(forKey: "isClient")
        if isClient != 1 {
            setupProfessionalCard()
            print("DEBUG: isClient Var HERE : ",isClient)
        }
        let size : CGFloat = 115
        picture.sd_setImage(with: URL(string: image),placeholderImage: UIImage(systemName: SFSymbols.profile))
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
        let hStack = HStackView(arrangedSubviews: [iconTitle,titleLabel,UIView()], spacing: 5)
        
        let vStackEditeButton = VerticalStackView(arrangedSubviews: [hStack,personalCard,professionalCard], spacing: 15)
        vStackEditeButton.distribution = .fillProportionally
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
    var image = ""
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = EditProfileViewController()
        controller.image = image
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
