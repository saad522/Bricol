//
//  OfferViewCell.swift
//  Bricol
//
//  Created by mac on 12/22/20.
//

import SwiftUI

let randomText = """
Winter weather can cause freezing in your
pipes that can lead to a burst pipe.
However, pipes can burst year-round.
Anything that causes a build-up of water
pressure in your pipes can cause it to burst
"""
class OfferViewCell : UICollectionViewCell {
    var didTapped : () -> () = {}
    var post : Post! {
        didSet {
            maxPriceLabel.text = " \(post.Max) DH "
            minPriceLabel.text = " \(post.Min) DH "
            descrptionLabel.text = post.about
            if post.isNegotiable == true {
                yesLabel.text = " Yes "
            } else if post.isNegotiable == false {
                yesLabel.text = " No "
            }
            
            let  picturesURL : [String] = [post.imageOne,post.imageTwo,post.imageTree,post.imageFour]
            picturesCellController.values = picturesURL
        }
    }
     
    private let contactMeButton      = UIButton(type : .system)
    private var moreDetailsButton    = UIButton(type : .system)
    private let picture = UIImageView(image : #imageLiteral(resourceName: "jamal"))
    private let name = UILabel(text: "Saad Saissi Hassni", font: .systemFont(ofSize: 18, weight: .bold), textColor: .black)
    private let adresse = UILabel(text: "Maroc,Casablanca", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .black)
    private let cityIcon = UIImageView(SFSymbols.location)
    private let maxLabel  = UILabel(text: "Max : ", font: .systemFont(ofSize: 16, weight: .medium), textColor: .secondary)
    private let minLabel  = UILabel(text: "Min : ", font: .systemFont(ofSize: 16, weight: .medium), textColor: .secondary)
    
    private let maxPriceLabel  = UILabel(text: " 350.00 DH ", font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white)
    
    private let minPriceLabel  = UILabel(text: " 250.00 DH ", font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white)
    
    private let viewText = UIView()
    private lazy var descrptionLabel = UILabel(text: randomText, font: .systemFont(ofSize: 16, weight: .bold),numberOfLines: 10, textColor: .secondary)
    
    private let negotaibleLabel  = UILabel(text: "Price Negotiable : ", font: .systemFont(ofSize: 14, weight: .semibold), textColor: .gray)
    
    private let yesLabel  = UILabel(text: " Yes ", font: .systemFont(ofSize: 20, weight: .semibold), textColor: .white)
    
    private lazy var picturesCellController = PicturesCellController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OfferViewCell {
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
    func setupNextButton() {
        contactMeButton.backgroundColor = UIColor(Color.buttonsColor)
        contactMeButton.shadow(UIColor(Color.buttonsColor))
        contactMeButton.setTitle("Contact me", for: .normal)
        contactMeButton.titleLabel?.font = .verdanaLight
        contactMeButton.constrainWidth(constant: 150)
        contactMeButton.layer.cornerRadius = 8
    }
    func setupPreviousButton() {
        moreDetailsButton.backgroundColor = .tertiarySystemBackground
        moreDetailsButton.setTitle("More details", for: .normal)
        moreDetailsButton.titleLabel?.font = .verdanaLight
        moreDetailsButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        moreDetailsButton.constrainWidth(constant: 150)
        moreDetailsButton.layer.cornerRadius = 8
        moreDetailsButton.layer.borderWidth = 1.5
        moreDetailsButton.layer.borderColor = UIColor(Color.buttonsColor).cgColor
        moreDetailsButton.addTarget(self, action: #selector(handleMoreDetails), for: .touchUpInside)
    }
    @objc func handleMoreDetails() {
        didTapped()
    }
    func  setUpPictures() {
        let size : CGFloat = 55
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.layer.cornerRadius = size / 2
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
    }
    func setUpViewTextProblem() {
        viewText.backgroundColor = .tertiarySystemGroupedBackground
//        viewText.shadow()
        viewText.layer.cornerRadius = 12
        viewText.constrainHeight(constant: 150)
        viewText.addSubview(descrptionLabel)
        descrptionLabel.fillSuperview(padding: .init(allInset: 15))
    }
    func creatUI() {
        setupNextButton()
        setupPreviousButton()
        setUpPictures()
        setUpViewTextProblem()
        setupPricing()
        let hStackLocation = HStackView(arrangedSubviews: [cityIcon,adresse,UIView()], spacing: 5)
        
        let vStackTop = VerticalStackView(arrangedSubviews: [name,hStackLocation], spacing: 5)
        
        
        let hStackTop = HStackView(arrangedSubviews: [picture,vStackTop], spacing: 10)
        addSubview(hStackTop)
        
        let hStackMin = HStackView(arrangedSubviews: [minLabel,minPriceLabel,UIView()], spacing: 5)
        
        let hStackMax = HStackView(arrangedSubviews: [maxLabel,maxPriceLabel], spacing: 5)
        
        let hStackPrice = HStackView(arrangedSubviews: [hStackMin,hStackMax], spacing: 10)
        
        let hStackNegotaible = HStackView(arrangedSubviews: [negotaibleLabel,yesLabel,UIView()], spacing: 5)
        
        let vStack = VerticalStackView(arrangedSubviews: [hStackPrice,hStackNegotaible], spacing: 10)
        
        let vStackCenter = VerticalStackView(arrangedSubviews: [viewText,vStack], spacing: 20)
        
        addSubview(vStackCenter)
        hStackTop.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(allInset: 10))
        vStackCenter.anchor(top: hStackTop.safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(allInset: 15))
        let buttonStack = HStackView(arrangedSubviews: [moreDetailsButton,contactMeButton], spacing: 10)
        buttonStack.distribution = .equalSpacing
        let vStackBottom = VerticalStackView(arrangedSubviews: [picturesCellController.view,buttonStack], spacing: 5)
        
        addSubview(vStackBottom)
        picturesCellController.view.constrainHeight(constant: 110)
        
        vStackBottom.anchor(top: vStackCenter.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(allInset: 10))
      
    }
}
