//
//  PicturesViewController.swift
//  Bricol
//
//  Created by mac on 12/23/20.
//

import SwiftUI

class PicturesViewController: UICollectionViewController {
    private let cellID = "cellID"
    //init: ComposotionalLayout
    init() {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [item])
//        group.contentInsets.trailing = 10
//        group.contentInsets.leading = 10
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.top = -45
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}
extension PicturesViewController {
    func setupCollectionView() {
        collectionView.backgroundColor = .tertiarySystemBackground
        collectionView.register(PicturesCellViews.self, forCellWithReuseIdentifier: cellID)
        collectionView.alwaysBounceVertical = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PicturesCellViews
        cell.backgroundColor = .systemYellow
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
}
struct PicturesView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = PicturesViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
     
}

struct PicturesViewController_Previews: PreviewProvider {
    static var previews: some View {
        PicturesView()
            .edgesIgnoringSafeArea(.all)
    }
}
