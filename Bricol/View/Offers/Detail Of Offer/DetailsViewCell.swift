//
//  DetailsViewCell.swift
//  Bricol
//
//  Created by mac on 12/23/20.
//

import SwiftUI

class DetailsViewCell: UICollectionViewCell {
    var post : Post! {
        didSet {
            descrptionLabel.text = post.about
            maxPriceLabel.text = " \(post.Max) DH "
            minPriceLabel.text = " \(post.Min) DH "
            descrptionLabel.text = post.about
            if post.isNegotiable == true {
                yesLabel.text = " Yes "
            } else if post.isNegotiable == false {
                yesLabel.text = " No "
            }
        }
    }
    
    private let adresse = UILabel(text: "Maroc,Casablanca Street N° 15 Rue Boulvard", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .secondary)
    
    private let location = UILabel(text: "Location", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .black)
    private let cityIcon = UIImageView(SFSymbols.location)
    
    private let viewText = UIView()
    private lazy var descrptionLabel = UILabel(text: randomText, font: .systemFont(ofSize: 16, weight: .bold),numberOfLines: 10, textColor: .secondary)
    private let maxLabel  = UILabel(text: "Max : ", font: .systemFont(ofSize: 16, weight: .medium), textColor: .secondary)
    private let minLabel  = UILabel(text: "Min : ", font: .systemFont(ofSize: 16, weight: .medium), textColor: .secondary)
    
    private let maxPriceLabel  = UILabel(text: " 350.00 DH ", font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white)
    
    private let minPriceLabel  = UILabel(text: " 250.00 DH ", font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white)
    
    private let negotaibleLabel  = UILabel(text: "Price Negotiable : ", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .gray)
    
    private let yesLabel  = UILabel(text: " Yes ", font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white)
    
    private let line = UIView(.systemGray)
    private let lineTwo = UIView(.systemGray)
    private let lineTree = UIView(.systemGray)
    private let contactMeButton      = UIButton(type : .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsViewCell {
    func setupNextButton() {
        contactMeButton.backgroundColor = UIColor(Color.buttonsColor)
        contactMeButton.shadow(UIColor(Color.buttonsColor))
        contactMeButton.setTitle("Contact me", for: .normal)
        contactMeButton.titleLabel?.font = .verdana
        contactMeButton.constrainWidth(constant: 150)
        contactMeButton.layer.cornerRadius = 8
    }
    func setupPricing() {
        maxPriceLabel.backgroundColor = UIColor(Color.buttonsColor)
        minPriceLabel.backgroundColor = UIColor(Color.buttonsColor)
        maxPriceLabel.layer.cornerRadius = 5
        maxPriceLabel.clipsToBounds = true
        
        minPriceLabel.layer.cornerRadius = 5
        minPriceLabel.clipsToBounds = true
        
        yesLabel.layer.cornerRadius = 5
        yesLabel.clipsToBounds = true
        yesLabel.backgroundColor = UIColor(Color.buttonsColor)

        
    }
    func setUpViewTextProblem() {
        viewText.backgroundColor = .white
        viewText.layer.cornerRadius = 12
        viewText.constrainHeight(constant: 150)
        viewText.addSubview(descrptionLabel)
        descrptionLabel.fillSuperview(padding: .init(allInset: 15))
    }
    func creatUI() {
        setUpViewTextProblem()
        setupPricing()
        setupNextButton()
        let hStackMin = HStackView(arrangedSubviews: [minLabel,UIView(),minPriceLabel,UIView()], spacing: 5)
        
        let hStackMax = HStackView(arrangedSubviews: [maxLabel,UIView(),maxPriceLabel,UIView()], spacing: 5)
        
        
        
        let hStackNegotaible = HStackView(arrangedSubviews: [negotaibleLabel,yesLabel,UIView()], spacing: 5)
        
        let vStackPrice = VerticalStackView(arrangedSubviews: [hStackMin,hStackMax], spacing: 10)
        
        let vStack = VerticalStackView(arrangedSubviews: [vStackPrice,hStackNegotaible], spacing: 10)
        let hStackLocation = HStackView(arrangedSubviews: [cityIcon,location,UIView()], spacing: 5)
        
        let vStackCenter = VerticalStackView(arrangedSubviews: [viewText,line,vStack,lineTwo,hStackLocation,adresse,lineTree,contactMeButton], spacing: 20)
        
        
        addSubview(vStackCenter)
        vStackCenter.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(allInset: 10))
        
        
      
    }
}
