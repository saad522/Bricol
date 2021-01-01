//
//  CategoryViewController.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import SwiftUI

class CategoryViewController: UICollectionViewController {
    //MARK:  Properties
    
    
    private let cellID = "cellID"
    private var users  = [User]()
    var city   = ""
    var metier = ""
    private let imageDesing = UIImageView(image : #imageLiteral(resourceName: "cherry"))
    private lazy var messageOne  = UILabel.init(text: "404\nThere are \nNo \(metier)s here", font: .verdana, numberOfLines: 3, textColor: .titlesColor)
    //init: ComposotionalLayout
    init(city : String?, metier : String?) {
        self.city = city ?? ""
        self.metier = metier ?? ""
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.bottom = 15
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(210)), subitems: [item])
        group.contentInsets.leading = 15
        group.contentInsets.trailing = 15
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        fetchHadymans()
    }
    deinit {
        print("All looks  good ✅ ")
    }
}
//MARK: setup Firebase
extension CategoryViewController {
    fileprivate func createDesign() {
        collectionView.addSubview(imageDesing)
//        imageDesing.backgroundColor = .white
//        imageDesing.centerInSuperview(size: .init(width: 284, height: 223))
        imageDesing.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(messageOne)
        messageOne.textAlignment = .center
        messageOne.tintAdjustmentMode = .dimmed
        messageOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageDesing.widthAnchor.constraint(equalToConstant: 211),
            imageDesing.heightAnchor.constraint(equalToConstant: 233),
            imageDesing.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 15),
            imageDesing.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            messageOne.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            messageOne.topAnchor.constraint(equalTo: imageDesing.bottomAnchor,constant: 15)
        ])
    
       
    }
    func fetchHadymans() {
        ServiceDatabase.shared.fetchHandymanInfo(city: city, metier: metier) { [weak self] (users, error) in
            if let error = error {
                print("Failed To Load All Handymans Data reason : ",error.localizedDescription)
                return
            }
            self?.users = users ?? []
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: setup CollectionView
extension CategoryViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if users.count == 0 {
            [self.imageDesing,self.messageOne].forEach({$0!.isHidden = false })
            return 0
        } else {
            [self.imageDesing,self.messageOne].forEach({$0!.isHidden = true })
            return users.count
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryViewCell
        let user = users[indexPath.item]
        cell.user = user
        cell.backgroundColor = .tertiarySystemBackground
        cell.didProfilTapped = { [weak self] in
            let user = self?.users[indexPath.item]
            let hadymanProfileViewController = HandymanProfileViewController(user: user)
            self?.navigationController?.pushViewController(hadymanProfileViewController, animated: true)
        }
        cell.didCallTapped = {
            let phoneNumber = "0694565607"
            let url = URL(string: "TEL://\(phoneNumber)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        cell.shadow()
        return cell
    }
    
    private func creatUI() {
        collectionView.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = metier
        cellRegistration()
        createDesign()
    }
    private func cellRegistration() {
        collectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: cellID)
    }
}
struct CategoryView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: CategoryViewController(city: nil, metier: nil))
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct CategoryViewController_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
            .edgesIgnoringSafeArea(.all)
    }
}
