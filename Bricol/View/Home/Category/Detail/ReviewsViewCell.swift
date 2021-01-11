//
//  ReviewsViewCell.swift
//  Bricol
//
//  Created by mac on 12/30/20.
//

import SwiftUI

let randomReview = """
Very respectful and kind people.
Great attention to detail, organized
and clean Definitely recommend
for feature jobs 👨🏻‍🔧 👍🏼
"""

class ReviewsViewCell: UICollectionViewCell {
    
    var review : Reviews! {
        didSet {
            name.text = review.clientName
            picture.sd_setImage(with: URL(string: review.clientPicture), placeholderImage: #imageLiteral(resourceName: "FaceTwo"))
            reviewDescrption.text = review.review
            if review.rate == 1 {
                [starTwo,starTree,starFour,starFive].forEach({$0.isHidden = true})
                starOne.isHidden = false
            } else if review.rate == 2 {
                [starTree,starFour,starFive].forEach({$0.isHidden = true})
                [starOne,starTwo].forEach({$0.isHidden = false})
            } else if review.rate == 3 {
                [starFour,starFive].forEach({$0.isHidden = true})
                [starOne,starTwo,starTree].forEach({$0.isHidden = false})
            } else if review.rate == 4 {
                [starFive].forEach({$0.isHidden = true})
                [starOne,starTwo,starTree,starFour].forEach({$0.isHidden = false})
            } else {
                [starOne,starTwo,starTree,starFour,starFive].forEach({$0.isHidden = false})
            }
        }
    }
    
    private let picture = UIImageView(image : #imageLiteral(resourceName: "jamal"))
    private let name = UILabel(text: "Saad Saissi Hassani", font: .verdanaTitle, textColor: .titlesColor)
    private let date = UILabel(text: "2 weeks ago", font: .systemFont(ofSize: 16, weight: .bold), textColor: .titlesColor)
    private let reviewDescrption = UILabel(text: randomReview, font: .verdanaSmall,numberOfLines: 10, textColor: .titlesColor)
    private let pictureCircle = UIView()
    private let starOne  = UIImageView(SFSymbols.star,size: 12,.systemOrange)
    private let starTwo  = UIImageView(SFSymbols.star,size: 12,.systemOrange)
    private let starTree = UIImageView(SFSymbols.star,size: 12,.systemOrange)
    private let starFour = UIImageView(SFSymbols.star,size: 12,.systemOrange)
    private let starFive = UIImageView(SFSymbols.star,size: 12,.systemOrange)

    var hStackStars = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ReviewsViewCell {
    func creatUI() {
        backgroundColor = .tertiarySystemBackground
        let size : CGFloat = 55
        picture.contentMode = .scaleAspectFill
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = size / 2
        pictureCircle.shadow()
        pictureCircle.addSubview(picture)
        picture.fillSuperview()
        hStackStars = HStackView(arrangedSubviews:
            [starOne,starTwo,starTree,starFour,starFive], spacing: 5)
        hStackStars.addArrangedSubview(UIView())
        let vStackName = VerticalStackView(arrangedSubviews: [name,hStackStars], spacing: 5)
        
        let hStack = HStackView(arrangedSubviews: [pictureCircle,vStackName], spacing: 10)
        
        let vStackTimer = VerticalStackView(arrangedSubviews: [date,reviewDescrption], spacing: 5)
        
        let vStack = VerticalStackView(arrangedSubviews: [hStack,vStackTimer], spacing: 10)
        
        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
   
}
