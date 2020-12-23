//
//  PicturesCellController.swift
//  Bricol
//
//  Created by mac on 12/23/20.
//

import SwiftUI

class PicturesCellController: UICollectionViewController {
    private let cellID = "cellID"
    //init: ComposotionalLayout
    init() {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 10
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets.leading = 10
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

extension PicturesCellController {
    func setupCollectionView() {
        collectionView.backgroundColor = .tertiarySystemBackground
        collectionView.register(PicturesViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PicturesViewCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
}
struct PicturesCell: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = PicturesCellController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    typealias UIViewControllerType = UIViewController
    
    
}

struct PicturesCellController_Previews: PreviewProvider {
    static var previews: some View {
        PicturesCell()
            .edgesIgnoringSafeArea(.all)
    }
}
