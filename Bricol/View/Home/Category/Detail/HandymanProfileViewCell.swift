//
//  HandymanProfileViewCell.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import SwiftUI

class HandymanProfileViewCell: UICollectionViewCell {
    
    var user : User? {
        didSet {
            title.text = user?.name ?? ""
            name.text  = user?.name ?? ""
            works.text = user?.work ?? ""
            if user?.status == true {
                status.text = "Available"
                status.textColor = UIColor(Color.buttonsColor)
            } else if user?.status == false {
                status.text = "Busy"
                status.textColor = .systemRed
            }
            reviews.text = user?.review ?? ""
            aboutLabel.text = user?.aboutMe ?? "Fix Broken Pipe 150 DH Floor installation 1000 DH \nMontage Mural 700 DH"
        }
    }
    
    var didPopTapped : () -> Void = {}
    var didCallTapped : () -> Void = {}
    
   private let title = UILabel(text: "Zakaria Lahrach", font: .systemFont(ofSize: 20, weight: .bold), textColor: .titlesColor)
    private  let name = UILabel(text: "Zakaria Lahrach", font: .verdana, textColor: .titlesColor)
    private  let worksLabel = UILabel(text: "Works", font: .systemFont(ofSize: 16, weight: .semibold),  textColor: .gray)
    private  let reviewsLabel = UILabel(text: "Reviews", font: .systemFont(ofSize: 16, weight: .semibold),  textColor: .gray)
    private  let statusLabel = UILabel(text: "Status", font: .systemFont(ofSize: 16, weight: .semibold),  textColor: .gray)
    private  let status = UILabel(text: "Available", font: .systemFont(ofSize: 16, weight: .black),  textColor: .gray)
    private  let reviews = UILabel(text: "59", font: .systemFont(ofSize: 16, weight: .semibold), textColor:  .gray)
    private  let works = UILabel(text: "100", font: .systemFont(ofSize: 16, weight: .semibold), textColor:  .gray)
    private  let star = UIImageView(SFSymbols.star,.systemYellow)
    private  let back = UIButton(with : SFSymbols.back)
    
    private let picture  = UIImageView(image : #imageLiteral(resourceName: "FaceTwo"))
    private let callCircle    = UIView()
    private let messageCircle = UIView()
    private let callIcon = UIButton(with : SFSymbols.call)
    private let message  = UIButton(with : SFSymbols.message)
    private let pictureCircle = UIView()
    
    private let nextButton      = UIButton(type : .system)
    private let previousButton  = UIButton(type : .system)
    
    private let about = UILabel(text: "About me", font: .verdana, textColor: .titlesColor)
    private let cardView = UIView()
    private let aboutLabel = UILabel(text: "Fix Broken Pipe 150 DH Floor installation 1000 DH \nMontage Mural 700 DH", font: .verdanaSmall, numberOfLines: 6, textColor: .titlesColor)
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension HandymanProfileViewCell {
    @objc func handleBack() {
        didPopTapped()
    }
    @objc func handleCall() {
        didCallTapped()
    }
    func setAction() {
        back.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        callIcon.addTarget(self, action: #selector(handleCall), for: .touchUpInside)
    }
    func setupAboutMe() {
        cardView.constrainHeight(constant: 125)
        cardView.shadow()
        cardView.backgroundColor = .tertiarySystemBackground
        
        cardView.addSubview(aboutLabel)
        aboutLabel.fillSuperview(padding: .init(allInset: 15))
        
    }
    func setupNextButton() {
        nextButton.backgroundColor = UIColor(Color.buttonsColor)
        nextButton.shadow(UIColor(Color.buttonsColor))
        nextButton.setTitle("You have a question", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        nextButton.constrainWidth(constant: 180)
        nextButton.layer.cornerRadius = 8
    }
    func setupPreviousButton() {
        previousButton.backgroundColor = .tertiarySystemBackground
        previousButton.setTitle("Leave Review", for: .normal)
        previousButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        previousButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        previousButton.constrainWidth(constant: 180)
        previousButton.layer.cornerRadius = 8
        previousButton.layer.borderWidth = 1.5
        previousButton.layer.borderColor = UIColor(Color.buttonsColor).cgColor
    }
    func setupCircles() {
        let size : CGFloat = 45
        [callCircle,messageCircle].forEach { (circle) in
            circle.constrainHeight(constant: size)
            circle.constrainWidth(constant: size)
            circle.layer.cornerRadius = size / 2
            circle.backgroundColor = .white
            circle.shadow()
        }
        
        callCircle.addSubview(callIcon)
        messageCircle.addSubview(message)
        [callIcon,message].forEach { (icon) in
            icon.fillSuperview(padding: .init(allInset: 7))
            icon.tintColor = UIColor(Color.buttonsColor)
        }

    }
    func creatUI() {
        setupAboutMe()
        setupCircles()
        setupPreviousButton()
        setupNextButton()
        let size : CGFloat = 115
        picture.contentMode = .scaleAspectFill
        picture.constrainWidth(constant: size)
        picture.constrainHeight(constant: size)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = size / 2
        pictureCircle.shadow()
        pictureCircle.addSubview(picture)
        picture.fillSuperview()
        
        let hStackCircles = HStackView(arrangedSubviews: [UIView(),messageCircle,callCircle], spacing: 10)
        let vStackStatus = VerticalStackView(arrangedSubviews: [statusLabel,status], spacing: 5)
        vStackStatus.alignment = .center
        
        let vStackWorks = VerticalStackView(arrangedSubviews: [worksLabel,works], spacing: 5)
        vStackStatus.alignment = .center
        
        let hStackReviews = HStackView(arrangedSubviews: [star,reviews,UIView()], spacing: 5)
        
        let vStackReviews = VerticalStackView(arrangedSubviews: [reviewsLabel,hStackReviews], spacing: 5)
        vStackStatus.alignment = .center
        
        let hStackBio = HStackView(arrangedSubviews: [vStackWorks,vStackStatus,vStackReviews], spacing: 15)
        
        let hStackBottom = HStackView(arrangedSubviews: [hStackBio,hStackCircles], spacing: 35)
        
        let hStackTop = HStackView(arrangedSubviews: [back,title,UIView()], spacing: 15)
        hStackTop.distribution = .equalCentering
        addSubview(hStackTop)
        let hStackPic = HStackView(arrangedSubviews: [UIView(),pictureCircle,UIView()], spacing: 5)
        hStackPic.alignment = .center
        addSubview(hStackPic)
        
        let buttonStack = HStackView(arrangedSubviews: [nextButton,previousButton], spacing: 15)
        buttonStack.distribution = .equalSpacing
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        let vStackAbout = VerticalStackView(arrangedSubviews: [about,cardView], spacing: 10)
        
        let vStack = VerticalStackView(arrangedSubviews: [name,hStackBottom,buttonStack,vStackAbout], spacing: 25)
        vStack.distribution = .fillProportionally
        addSubview(vStack)
        
        
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        hStackTop.translatesAutoresizingMaskIntoConstraints = false
        hStackPic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStackTop.topAnchor.constraint(equalTo: topAnchor),
            hStackTop.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStackTop.trailingAnchor.constraint(equalTo:trailingAnchor),
            
            hStackPic.topAnchor.constraint(equalTo: hStackTop.bottomAnchor,constant: 15),
            hStackPic.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            vStack.topAnchor.constraint(equalTo: hStackPic.bottomAnchor,constant: 15),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            vStack.trailingAnchor.constraint(equalTo:trailingAnchor,constant: -10),
            
        ])
    }
}
