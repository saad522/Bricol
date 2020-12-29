//
//  CardView.swift
//  Bricol
//
//  Created by mac on 12/19/20.
//

import SwiftUI

enum Sizes {
    static let cardSizeHeight : CGFloat = 270
    static let carSizeWidth   : CGFloat = 155
}
typealias size = Sizes

class CardView: UIView {
    var label = UILabel()
    init(image : UIImage, name : String,sizes : CGSize) {
        super.init(frame: .zero)
        setComponents(with: image, and: name,and: sizes)
    }
    
    
    func setComponents(with image : UIImage,and name : String,and sizes : CGSize) {
        
        let icon = UIImageView(image : image)
        
        label = UILabel.init(text: name, font: .verdanaMedium, textColor: .gray)
        label.textAlignment = .center
        
        
        icon.constrainWidth(constant: sizes.width)
        icon.constrainHeight(constant: sizes.width)
        icon.contentMode = .scaleAspectFit
   
        [icon,label]
            .forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        addSubview(icon)
        addSubview(label)
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 15),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        constrainHeight(constant: size.cardSizeHeight)
        constrainWidth(constant: size.carSizeWidth)
        backgroundColor = .systemBackground
        layer.cornerRadius = 12

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
