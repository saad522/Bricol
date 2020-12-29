//
//  HandymanProfileViewController.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import SwiftUI

class HandymanProfileViewController: UICollectionViewController {
    
    //MARK: Properties
    private let cellID       = "cellID"
    private let secondCellID = "secondCellID"
    private let headerID     = "headerID"
    //init: ComposotionalLayout
    init() {

        let layout = UICollectionViewCompositionalLayout { (numberOfsection, _) -> NSCollectionLayoutSection? in
            
            if numberOfsection == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(530)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 8
                item.contentInsets.trailing = 8
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
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
        creatUI()
    }
}
//MARK: setup CollectionView
extension HandymanProfileViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return section == 0 ? 1 : 5 }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HandymanProfileViewCell
            cell.didPopTapped = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            cell.backgroundColor = .secondarySystemBackground
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CompositionalHeader
        header.label.text = "Reviews"
        return header
    }
   private func creatUI() {
        collectionView.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        cellRegistration()
    }
    private func cellRegistration() {
        collectionView.register(HandymanProfileViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: secondCellID)
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
}
struct HandymanProfileView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: HandymanProfileViewController())
        
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
    typealias UIViewControllerType = UIViewController
    
}

struct HandymanProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        HandymanProfileView()
            .edgesIgnoringSafeArea(.all)
    }
}
