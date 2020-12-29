//
//  MoreDetailsViewController.swift
//  Bricol
//
//  Created by mac on 12/23/20.
//

import SwiftUI

class MoreDetailsViewController: UICollectionViewController {
    
    fileprivate let cellId = "cellId"
    private let secondCellID = "secondCellID"
    var pictures : [String] = [String]()
    var values : Post?
    
    fileprivate let padding: CGFloat = 16
    init() {
        
        
        let layout = UICollectionViewCompositionalLayout { (numberOfSection,_) -> NSCollectionLayoutSection? in
            if numberOfSection == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets.bottom  = 25
                return section
            }
    else {
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(350)), subitems: [item])
                group.contentInsets.bottom   = 10
            let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.bottom = 160
            return section
        }
            
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
   
}

extension MoreDetailsViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return section == 0 ? pictures.count : 1
    }
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .secondarySystemBackground
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "More Details"
        navigationController?.isNavigationBarHidden = true
        collectionView.register(PicturesCellViews.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(DetailsViewCell.self, forCellWithReuseIdentifier: secondCellID)
       
    }
 
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PicturesCellViews
            let picture = pictures[indexPath.item]
            cell.picture.sd_setImage(with: URL(string: picture))
            cell.backgroundColor = .tertiarySystemBackground
            cell.didTappedDismiss = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                print("Did Tapped")
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! DetailsViewCell
            let post = values
            cell.post = post
            return cell
        }
        
    }

}
struct MoreDetailsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller =  MoreDetailsViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct MoreDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailsView()
            .edgesIgnoringSafeArea(.all)
    }
}
