//
//  CardPosteViewCell.swift
//  Bricol
//
//  Created by mac on 12/20/20.
//

import SwiftUI

class CardPosteViewCell: UICollectionViewCell {
    var didPostTapped : () -> () = {}
    
    let profile = UIImageView()
    var name = UILabel(text: "Bonjour, Othman", font: .verdanaTitle, textColor: Color.white)
    let question = UILabel(text: "Puis je vous aider ? 👨🏻‍🔧", font: .systemFont(ofSize: 20, weight: .bold), textColor: Color.white)
    let message = UILabel(text: "Postez votre problème et attendez les réponses de nos bricoleurs", font: .systemFont(ofSize: 20, weight: .regular),numberOfLines: 2, textColor: Color.white)
    let postButton = UIButton(type : .system)
    let view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CardPosteViewCell {
    func setupImage() {        
        profile.image = #imageLiteral(resourceName: "jamal")
        profile.contentMode = .scaleAspectFill
        profile.clipsToBounds = true
        let size : CGFloat = 50
        profile.constrainWidth(constant: size)
        profile.constrainHeight(constant: size)
        profile.layer.cornerRadius = size / 2
        profile.layer.borderWidth = 1.5
        profile.layer.borderColor = UIColor.white.cgColor
       
    }
    func setupPostButton() {
        postButton.backgroundColor = .tertiarySystemBackground
        postButton.setTitle("Poster", for: .normal)
        postButton.titleLabel?.font = .verdana
        postButton.setTitleColor(UIColor(Color.buttonsColor), for: .normal)
        postButton.constrainWidth(constant: 180)
        postButton.layer.cornerRadius = 8
        postButton.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
    }
    @objc func handlePostButton() {
        didPostTapped()
    }
    func creatUI() {
        setupPostButton()
        setupImage()
        addSubview(view)
        view.fillSuperview()
        let hStack = HStackView(arrangedSubviews: [name,UIView(),profile], spacing: 0)
        
        let vStack = VerticalStackView(arrangedSubviews: [hStack,question,message,postButton], spacing: 20)
        view.addSubview(vStack)
        vStack.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 0, right: 15))
        layer.cornerRadius = 12
        view.clipsToBounds = true
        shadow()
        
    }
}
