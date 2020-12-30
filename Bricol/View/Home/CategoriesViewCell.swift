//
//  CategoriesViewCell.swift
//  Bricol
//
//  Created by mac on 12/20/20.
//

import UIKit

class CategoriesViewCell: UICollectionViewCell {
    
    
    let picture = UIImageView(image : UIImage(systemName: SFSymbols.tools))
    let title = UILabel()
    let count = UILabel()
    private let pictureCircle = UIView()

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
        let size : CGFloat = 35
        picture.contentMode = .center
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.layer.cornerRadius = size / 2
        pictureCircle.shadow()
        pictureCircle.addSubview(picture)
        picture.fillSuperview()
        picture.tintColor = .black
        picture.backgroundColor = .white
        
    }
    func setTitle() {
        title.text = "Plombier"
        title.font = .verdanaTitle
        title.textColor = .white
        title.textAlignment = .center
        
        count.text = "30 Plombiers"
        count.font = .systemFont(ofSize: 16, weight: .bold)
        count.textColor = .white
        count.textAlignment = .center
    }
    func creatUI() {
        setImage()
        setTitle()
        layer.cornerRadius = 5
        let hStack = HStackView(arrangedSubviews: [pictureCircle,count], spacing: 10)
        let vStack = VerticalStackView(arrangedSubviews: [hStack,title], spacing: 10)
        vStack.alignment = .leading
        addSubview(vStack)
        backgroundColor = .systemGreen
        shadow()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
}
