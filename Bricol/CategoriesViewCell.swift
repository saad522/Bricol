//
//  CategoriesViewCell.swift
//  Bricol
//
//  Created by mac on 12/20/20.
//

import UIKit
struct Categorie {
    let image : UIImage
    let title : String
}
class CategoriesViewCell: UICollectionViewCell {
    var categorie : Categorie! {
        didSet {
            title.text = categorie.title
            imageProfile.image = categorie.image
        }
    }
    
    let imageProfile = UIImageView()
    let title = UILabel()
    let view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoriesViewCell {
    func setImage() {
        imageProfile.image = #imageLiteral(resourceName: "Handyman3")
        imageProfile.contentMode = .scaleAspectFit
        imageProfile.constrainHeight(constant: 155)
        imageProfile.constrainWidth(constant: 134)
        
    }
    func setTitle() {
        title.text = "Plombier"
        title.font = .verdanaTitle
        title.textColor = .label
        title.textAlignment = .center
    }
    func creatUI() {
        setImage()
        setTitle()
        addSubview(view)
        view.fillSuperview()
        layer.cornerRadius = 12
        let vStack = VerticalStackView(arrangedSubviews: [imageProfile,title], spacing: 10)
        view.addSubview(vStack)
        shadow()
        vStack.centerInSuperview()
        
    }
}
