//
//  HomeViewControllert.swift
//  Bricol
//
//  Created by mac on 12/20/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class HomeViewControllert: UICollectionViewController {
    //MARK: Properties
    private let firstCellID    = "firstCellID"
    private let headerID       = "headerID"
    private let secondeCellID  = "secondeCellID"
    private var user : User?
    let skills = MountainsController()
    private let sideMenuButton = UIButton(type : .system)
     
    //init: ComposotionalLayout
    init() {
        
        
        let layout = UICollectionViewCompositionalLayout { (numberOfsection, _) -> NSCollectionLayoutSection? in
            
            if numberOfsection == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                group.contentInsets.leading = 15
                group.contentInsets.trailing = 15
                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets.top = 40
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 15, leading: 10, bottom: 5, trailing: 10)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: kind, alignment: .top)
                ]
                return section
            }
          
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollevtionView()
        checkIfUserLoggedIn()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        fetchUserData()
    }
    deinit {
        print("All looks  good ✅ ")
    }
}

//MARK: Configure CollectionViewLayout & DataSource
extension HomeViewControllert {
    func setupCollevtionView() {
        collectionView.backgroundColor = .secondarySystemBackground
        creatUI()
        cellRegistration()
    }
    func cellRegistration() {
        collectionView.register(CardPosteViewCell.self, forCellWithReuseIdentifier: firstCellID)
        collectionView.register(CategoriesViewCell.self, forCellWithReuseIdentifier: secondeCellID)
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : skills.mountains.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellID, for: indexPath) as! CardPosteViewCell
            cell.name.text = "Bonjour,\(user?.name ?? "")"
            
            cell.profile.sd_setImage(with: URL(string: user?.pictureProfile ?? ""), placeholderImage: #imageLiteral(resourceName: "FaceTwo"))
            cell.backgroundColor = .systemGreen
            cell.didPostTapped = { [weak self] in
                print("Did Post Taped")
                let creatPostViewController = CreatePostViewController()
                let controller = UINavigationController(rootViewController: creatPostViewController)
                controller.modalPresentationStyle = .fullScreen
                self?.present(controller, animated: true)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondeCellID, for: indexPath) as! CategoriesViewCell
            cell.title.text = skills.generateMountains()[indexPath.item].name
            let random = Int.random(in: 1..<45)
        
                cell.count.text = "\(random) \(skills.generateMountains()[indexPath.item].name)s"
            
            return cell
        }
    }
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("Tapped")
        }
        else if indexPath.section == 1 {
            let city = user?.city
            let metier = skills.generateMountains()[indexPath.item].name
            
            let controller =  CategoryViewController(city: city, metier: metier)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CompositionalHeader
        return header
    }
}
//MARK: Create UI
 extension HomeViewControllert {
    
    func fetchUserData() {
        ServiceDatabase.shared.fetchUserInfo { [weak self] (user, error) in
            if let error = error {
                print("Failed To Load User Information reason : ",error.localizedDescription)
                return
            }
            self?.user = user
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    func setActions() {
        sideMenuButton.addTarget(self, action: #selector(handleSideMenu), for: .touchUpInside)
    }
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            let loginController = RegisterViewController()
            loginController.homeViewController = self
            let controller = UINavigationController(rootViewController: loginController)
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true)
        }
    }
    @objc func handleSideMenu() {
        print("Side Menu Presented...")
        signOut()
    }
     func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    func setupSideMenuButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.sideMenu,withConfiguration:  UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy, scale: .large))?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSideMenu))
        navigationController?.navigationBar.barTintColor = UIColor.secondarySystemBackground
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func creatUI() {
        setupSideMenuButton()
        setActions()
    }
}

struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: HomeViewControllert())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    typealias UIViewControllerType = UIViewController
    
    
}

struct HomeViewControllert_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .edgesIgnoringSafeArea(.all)
    }
}
