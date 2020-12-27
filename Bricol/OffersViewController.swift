//
//  OffersViewController.swift
//  Bricol
//
//  Created by mac on 12/22/20.
//

import SwiftUI

class OffersViewController: UICollectionViewController {
    private let cellID = "cellID"
    var posts = [Post]()
    
    //init: ComposotionalLayout
    init() {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(500)), subitems: [item])
        group.contentInsets.leading  = 10
        group.contentInsets.trailing = 10
        group.contentInsets.bottom   = 10
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        fetchUserData()
    }
}

//MARK: Configuretion of CollectionView
extension OffersViewController {
    func fetchUserData() {
        ServiceDatabase.shared.fetchUsersData { (posts, error) in
            if let error = error {
                print("Failed To Fetch Posts reason : ",error.localizedDescription)
                return
            }
            self.posts = posts ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    func setupCollectionView() {
        collectionView.register(OfferViewCell.self, forCellWithReuseIdentifier: cellID)
    }
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! OfferViewCell
        let post = posts[indexPath.item]
        cell.post = post
        
        cell.shadow()
        cell.layer.cornerRadius = 3
        cell.backgroundColor = .tertiarySystemBackground
        cell.didTapped = { [weak self] in
            let controller = MoreDetailsViewController()
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
}
//MARK: creatUI
private extension OffersViewController {
    func creatUI() {
        collectionView.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Offers"
    }
}
struct OffersView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: OffersViewController())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct OffersViewController_Previews: PreviewProvider {
    static var previews: some View {
        OffersView()
            .edgesIgnoringSafeArea(.all)
    }
}
