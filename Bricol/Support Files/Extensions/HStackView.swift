//
//  HStackView.swift
//  iDelivery
//
//  Created by mac on 10/27/20.
//

import UIKit

class HStackView: UIStackView {
	init(arrangedSubviews: [UIView],spacing : CGFloat = 10) {
		super.init(frame: .zero)
		arrangedSubviews.forEach({addArrangedSubview($0)})
		self.spacing = spacing
		self.axis = .horizontal
		self.alignment = .center
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
