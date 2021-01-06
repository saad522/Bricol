//
//  CategoryViewCell.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import SwiftUI

class CategoryViewCell: UICollectionViewCell {
    
    var user : User? {
        didSet {
            name.text = user?.name
            location.text = "Maroc, \(user?.city ?? "")"
            picture.sd_setImage(with: URL(string: user?.pictureProfile ?? ""), placeholderImage: #imageLiteral(resourceName: "FaceTwo"))
            if user?.status == true {
                status.text = "Available"
                status.textColor = UIColor(Color.buttonsColor)
            } else if user?.status == false {
                status.text = "Busy"
                status.textColor = .systemRed
            }
            reviews.text = "\(user?.review ?? "") reviews"
        }
    }
    
    var didProfilTapped : () -> () = {}
    var didCallTapped : () -> Void = {}
    
    private let picture  = UIImageView(image : #imageLiteral(resourceName: "FaceTwo"))
    private let cityIcon = UIImageView(SFSymbols.location)
    private let star     = UIImageView(SFSymbols.star,.systemOrange)
    
    private let name     =
        UILabel(text: "Zakaria Lahrach", font: .verdanaTitle, textColor: .titlesColor)
    private let location =
        UILabel(text: "Maroc,Tangier", font: .systemFont(ofSize: 16, weight: .medium), textColor: .black)
    private let reviews  =
        UILabel(text: "59 reviews", font: .systemFont(ofSize: 16, weight: .semibold), textColor: .gray)
    private let statusLabel =
        UILabel(text: "Status", font: .systemFont(ofSize: 16, weight: .semibold), textColor: .gray)
    private let status      =
        UILabel(text: "Available", font: .systemFont(ofSize: 16, weight: .black), textColor: .buttonsColor)
   
    
    private let callIcon = UIButton(with : SFSymbols.call)
    private let message  = UIButton(with : SFSymbols.message)
    private let profile  = UIButton(with : SFSymbols.profile)
    
    private let pictureCircle = UIView()
    private let callCircle    = UIView()
    private let messageCircle = UIView()
    private let profileCircle = UIView()
    private let line          = UIView(.systemGray)
    var starIcons: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryViewCell {
    @objc func handlePrfile() {
        didProfilTapped()
    }
    @objc func handleCall() {
        didCallTapped()
    }
    func setAction() {
        profile.addTarget(self, action: #selector(handlePrfile), for: .touchUpInside)
        callIcon.addTarget(self, action: #selector(handleCall), for: .touchUpInside)
    }
    func setupCircles() {
        let size : CGFloat = 45
        [callCircle,messageCircle,profileCircle].forEach { (circle) in
            circle.constrainHeight(constant: size)
            circle.constrainWidth(constant: size)
            circle.layer.cornerRadius = size / 2
            circle.backgroundColor = .white
            circle.shadow()
        }
        
        callCircle.addSubview(callIcon)
        messageCircle.addSubview(message)
        profileCircle.addSubview(profile)
        [callIcon,message,profile].forEach { (icon) in
            icon.fillSuperview(padding: .init(allInset: 7))
            icon.tintColor = UIColor(Color.buttonsColor)
        }

    }
    func creatUI() {
        setupCircles()
        line.constrainHeight(constant: 0.4)
        
        let size : CGFloat = 75
        picture.contentMode = .scaleAspectFill
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = size / 2
        pictureCircle.shadow()
        pictureCircle.addSubview(picture)
        picture.fillSuperview()
        let hStackStars = HStackView(arrangedSubviews: createStars(digits: 5), spacing: 5)
        let hStackReviews = HStackView(arrangedSubviews: [hStackStars,reviews,UIView()], spacing: 5)
        let hStackLocation = HStackView(arrangedSubviews: [cityIcon,location,UIView()], spacing: 5)
        
        let vStack = VerticalStackView(arrangedSubviews: [name,hStackReviews,hStackLocation], spacing: 10)
        
        let hStack = HStackView(arrangedSubviews: [pictureCircle,vStack], spacing: 10)
        let hStackCircles = HStackView(arrangedSubviews: [UIView(),profileCircle,messageCircle,callCircle], spacing: 10)
        let vStackStatus = VerticalStackView(arrangedSubviews: [statusLabel,status], spacing: 5)
        vStackStatus.alignment = .center
        let hStackBottom = HStackView(arrangedSubviews: [vStackStatus,hStackCircles], spacing: 10)
        
        let vStackCenter = VerticalStackView(arrangedSubviews: [hStack,line,hStackBottom])
    
        vStackCenter.distribution = .fillProportionally
        addSubview(vStackCenter)
        vStackCenter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackCenter.topAnchor.constraint(equalTo: topAnchor),
            vStackCenter.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            vStackCenter.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            vStackCenter.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10)
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
