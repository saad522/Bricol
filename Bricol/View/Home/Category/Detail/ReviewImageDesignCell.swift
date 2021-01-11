//
//  ReviewImageDesignCell.swift
//  Bricol
//
//  Created by mac on 1/11/21.
//

import SwiftUI

class ReviewImageDesignCell: UICollectionViewCell {
    
    let imageDesign = UIImageView(image : #imageLiteral(resourceName: "kingdom"))
    let messageLabel = UILabel(text: "Give us a review", font: .verdanaTitle, textColor: Color(.label))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    func creatUI() {
        imageDesign.constrainHeight(constant: 150)
        imageDesign.constrainWidth(constant: 200)
        imageDesign.contentMode = .scaleAspectFill
        let vStack =  VerticalStackView(arrangedSubviews: [imageDesign,messageLabel], spacing: 10)
        vStack.alignment = .center
        addSubview(vStack)
        vStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(allInset: 10))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
