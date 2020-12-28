//
//  IndustryViewController.swift
//  Bricol
//
//  Created by mac on 12/28/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class IndustryViewController: UICollectionViewController {
    //MARK: Properties
    private let cellID = "cellID"
    let searchController = UISearchController(searchResultsController: nil)
    var nameFilter: String?
    var dataSource: UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>!
    enum Section: CaseIterable {
        case main
    }
    let mountainsController = MountainsController()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
    }
    //MARK: ComposotionalLayout
    init() {
        let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: setUp NavigationController
extension IndustryViewController : UISearchBarDelegate {
    fileprivate func setUpNavigation() {
        navigationItem.title = "Search by Industry"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        collectionView.backgroundColor = .systemBackground
  
    }
    
    func setupSearchViewController() {
        setUpNavigation()
        configureDataSource()
        performQuery(with: nil)
        
    }
    
}
//MARK: Configure Firebase
extension IndustryViewController {
    fileprivate func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            let loginViewScreen = LoginViewController()
            let controller = UINavigationController(rootViewController: loginViewScreen)
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true)
        } else {
            setupSearchViewController()
        }
    }
}
extension IndustryViewController {
    /// - Tag: SearchViewControllerDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <SearchViewCell, MountainsController.Mountain> { (cell, indexPath, mountain) in
            // Populate the cell with our item description.
            cell.name.text = mountain.name
            let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
            cell.name.font = UIFont(name: fontName, size: 16)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, MountainsController.Mountain>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: MountainsController.Mountain) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = dataSource.itemIdentifier(for: indexPath)
      
        let offerViewController = OffersViewController(industry: object?.name)
        
        navigationController?.pushViewController(offerViewController, animated: true)
        offerViewController.navigationItem.title = object?.name ?? "Offers"
    }
    /// - Tag: MountainsPerformQuery
    func performQuery(with filter: String?) {
        let mountains = mountainsController.filteredMountains(with: filter).sorted { $0.name < $1.name }
            
        var snapshot = NSDiffableDataSourceSnapshot<Section, MountainsController.Mountain>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mountains)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
struct IndustryView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: IndustryViewController())
        return  controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
   
}

struct IndustryViewController_Previews: PreviewProvider {
    static var previews: some View {
        IndustryView()
            .edgesIgnoringSafeArea(.all)
    }
}
