//
//  HeaderView.swift
//  Bricol
//
//  Created by mac on 12/23/20.
//

import UIKit

class HeaderView: UICollectionViewCell {
    private let pictures = PicturesViewController()
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "broken-pipe-water"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        
        backgroundColor = .red
        
        addSubview(pictures.view)
        pictures.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
