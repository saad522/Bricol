//
//  CompositionalHeader.swift
//  Bricol
//
//  Created by mac on 12/20/20.
//

import SwiftUI
class CompositionalHeader: UICollectionReusableView {
    
    private let label = UILabel(text: "Categories", font: .verdana, textColor: Color.titlesColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.fillSuperview(padding:.init(top: 15, left: 15, bottom: 0, right: 0))
    }
  

    required init?(coder: NSCoder) {
        fatalError()
    }
}
