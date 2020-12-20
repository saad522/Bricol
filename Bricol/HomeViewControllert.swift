//
//  HomeViewControllert.swift
//  Bricol
//
//  Created by mac on 12/20/20.
//

import SwiftUI

class HomeViewControllert: UICollectionViewController {
    //MARK: Properties
    private let firstCellID    = "firstCellID"
    private let headerID       = "headerID"
    private let secondeCellID  = "secondeCellID"
    private let sideMenuButton = UIButton(type : .system)
    private var categories : [Categorie]  = [
        .init(image: #imageLiteral(resourceName: "Handyman3"), title: "Plombier"),
        .init(image: #imageLiteral(resourceName: "Handyman2"), title: "Électrique"),
        .init(image: #imageLiteral(resourceName: "Handyman"), title: "Teinturier"),
        .init(image: #imageLiteral(resourceName: "XMLID_83_"), title: "Charpentier")
    ]
    
    //init: ComposotionalLayout
    init() {
        
        
        let layout = UICollectionViewCompositionalLayout { (numberOfsection, _) -> NSCollectionLayoutSection? in
            
            if numberOfsection == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                group.contentInsets.leading = 15
                group.contentInsets.trailing = 15
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 40
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top: 15, leading: 15, bottom: 15, trailing: 15)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                
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
        setDevelopmentPresnted()
    }
    func setDevelopmentPresnted() {
        perform(#selector(handlePresent), with: self, afterDelay: 0)
    }
    @objc func handlePresent() {
        let loginViewController = LoginViewController()
        let controller = UINavigationController(rootViewController: loginViewController)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
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
        return section == 0 ? 1 : 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellID, for: indexPath) as! CardPosteViewCell
            cell.backgroundColor = .systemGreen
            cell.didPostTapped = {
                print("Did Post Taped")
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondeCellID, for: indexPath) as! CategoriesViewCell
            cell.backgroundColor = .tertiarySystemBackground
            let categorie = categories[indexPath.item]
            cell.categorie = categorie
            return cell
        }
    }
   
        
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CompositionalHeader
        return header
    }
}
//MARK: Create UI
private extension HomeViewControllert {
    func setActions() {
        sideMenuButton.addTarget(self, action: #selector(handleSideMenu), for: .touchUpInside)
    }
    @objc func handleSideMenu() {
        print("Side Menu Presented...")
    }
    func setupSideMenuButton() {
        sideMenuButton.setImage(UIImage(systemName: SFSymbols.sideMenu,withConfiguration:  UIImage.SymbolConfiguration(pointSize: 25, weight: .heavy, scale: .large)), for: .normal)
        sideMenuButton.tintColor = .label
        
    }
    func creatUI() {
        setupSideMenuButton()
        setActions()
        collectionView.addSubview(sideMenuButton)
        sideMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 10),
            sideMenuButton.bottomAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor,constant: 20)
        ])
    }
}

struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = HomeViewControllert()
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
