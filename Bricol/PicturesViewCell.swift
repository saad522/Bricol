//
//  PicturesViewCell.swift
//  Bricol
//
//  Created by mac on 12/23/20.
//

import UIKit


class PicturesViewCell: UICollectionViewCell {
    let picture = UIImageView(image : #imageLiteral(resourceName: "broken-pipe-water"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PicturesViewCell {
    func  creatUI() {
        addSubview(picture)
        picture.contentMode = .scaleAspectFit
        picture.fillSuperview()
        
    }
}


class PicturesCellViews: UICollectionViewCell {
    let picture = UIImageView(image : #imageLiteral(resourceName: "broken-pipe-water"))
    let dismissButton = UIButton(SFSymbols.dismiss)
    var didTappedDismiss : () -> () = { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PicturesCellViews {
    func  creatUI() {
        addSubview(picture)
        picture.contentMode = .scaleAspectFit
        picture.layer.cornerRadius = 12
        picture.clipsToBounds = true
        dismissButton.tintColor = .black
        dismissButton.constrainWidth(constant: 35)
        dismissButton.constrainHeight(constant: 35)
        picture.isUserInteractionEnabled = true
//        picture.constrainWidth(constant: 450)
//        picture.constrainHeight(constant: 450)
        picture.centerInSuperview(size: .init(width: 450, height: 450))
        picture.addSubview(dismissButton)
        dismissButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(allInset: 5))
        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    @objc func handleDismiss() {
        didTappedDismiss()
    }
}
