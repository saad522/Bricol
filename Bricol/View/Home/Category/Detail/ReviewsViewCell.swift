//
//  ReviewsViewCell.swift
//  Bricol
//
//  Created by mac on 12/30/20.
//

import UIKit

let randomReview = """
Very respectful and kind people.
Great attention to detail, organized
and clean Definitely recommend
for feature jobs 👨🏻‍🔧 👍🏼
"""

class ReviewsViewCell: UICollectionViewCell {
    
    private let picture = UIImageView(image : #imageLiteral(resourceName: "jamal"))
    private let name = UILabel(text: "Saad Saissi Hassani", font: .verdanaTitle, textColor: .titlesColor)
    private let date = UILabel(text: "2 weeks ago", font: .systemFont(ofSize: 16, weight: .bold), textColor: .titlesColor)
    private let review = UILabel(text: randomReview, font: .verdanaSmall,numberOfLines: 10, textColor: .titlesColor)
    private let pictureCircle = UIView()
    var starIcons: [UIImageView] = []
    
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
        let size : CGFloat = 55
        picture.contentMode = .scaleAspectFill
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = size / 2
        pictureCircle.shadow()
        pictureCircle.addSubview(picture)
        picture.fillSuperview()
        
        let hStackStars = HStackView(arrangedSubviews: createStars(digits: 3), spacing: 5)
        hStackStars.addArrangedSubview(UIView())
        let vStackName = VerticalStackView(arrangedSubviews: [name,hStackStars], spacing: 5)
        
        let hStack = HStackView(arrangedSubviews: [pictureCircle,vStackName], spacing: 10)
        
        let vStackTimer = VerticalStackView(arrangedSubviews: [date,review], spacing: 5)
        
        let vStack = VerticalStackView(arrangedSubviews: [hStack,vStackTimer], spacing: 10)
        
        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    func createStars(digits: Int) -> [UIImageView] {
        var counter = 0
        
        for _ in 0..<digits {
            let star = UIImageView(SFSymbols.star,size: 12,.systemOrange)
            counter += 1
            starIcons.append(star)
//            if counter == digits {
//                starIcons.append(UIImageView())
//            }
        }
        return starIcons
    }
}
