//
//  SearchViewCell.swift
//  Bricol
//
//  Created by mac on 12/28/20.
//

import UIKit

class SearchViewCell: UICollectionViewCell {
    //MARK: Properties
    let name = UILabel(text: "Plombier", font: UIFont(name: "Avenir-Book", size: 16)!, textColor: .black)
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
}

extension SearchViewCell {
    fileprivate func creatUI() {
        addSubview(name)
        name.fillSuperview(padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        name.textAlignment = .center
        backgroundColor = .tertiarySystemBackground
        layer.cornerRadius = 15
        layer.shadowOpacity = 0.2
        layer.shadowRadius  = 2
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOffset  = .init(width: 0, height: 2)
    }
}
