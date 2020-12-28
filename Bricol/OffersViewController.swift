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
    fileprivate let industry: String?
    //init: ComposotionalLayout
    init(industry: String?) {
        self.industry = industry
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
        let mainTabBarController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController as? MainTabBarController
        mainTabBarController?.viewControllers![1].tabBarItem.badgeValue = nil
    }
}

//MARK: Configuretion of CollectionView
extension OffersViewController {
    func fetchUserData() {
        guard let industry = industry else { return  }
        ServiceDatabase.shared.fetchPostsData(industry: industry) { (posts, error) in
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
        let pictures : [String] = [post.imageOne,post.imageTwo,post.imageTree,post.imageFour]
        
        cell.shadow()
        cell.layer.cornerRadius = 3
        cell.backgroundColor = .tertiarySystemBackground
        cell.didTapped = { [weak self] in
            let controller = MoreDetailsViewController()
            controller.pictures = pictures
            controller.values = self?.posts ?? []
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
        let controller = UINavigationController(rootViewController: OffersViewController(industry: nil))
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
