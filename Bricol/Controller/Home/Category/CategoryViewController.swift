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
    //init: ComposotionalLayout
    init() {
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
    }
}
//MARK: setup CollectionView
extension CategoryViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryViewCell
        cell.backgroundColor = .tertiarySystemBackground
        cell.didProfilTapped = { [weak self] in
            self?.navigationController?.pushViewController(HandymanProfileViewController(), animated: true)
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
    navigationItem.title = "Plombier"
        cellRegistration()
    }
    private func cellRegistration() {
        collectionView.register(CategoryViewCell.self, forCellWithReuseIdentifier: cellID)
    }
}
struct CategoryView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: CategoryViewController())
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
