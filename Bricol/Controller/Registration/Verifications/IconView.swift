//
//  IconView.swift
//  Bricol
//
//  Created by mac on 12/18/20.
//

import UIKit

class IconView: UIView {

    let image = UIImageView(initialImage: #imageLiteral(resourceName: "Image"), useContenMode: .scaleAspectFit)
    let duration : TimeInterval = 0.3
    
    init(size: CGFloat = 55) {
        super.init(frame: .zero)

        backgroundColor = .white

        constrainWidth(constant: size)
        constrainHeight(constant: size)

        addSubview(image)
        image.fillSuperview(padding: .init(allInset: 10))
    }

    func animateArrow() {
        // swiftlint:disable line_length multiple_closures_with_trailing_closure
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.image.transform = CGAffineTransform(translationX: -10, y: 0 )
        }) { (_) in
            UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.image.transform = CGAffineTransform(translationX: 60, y: 0)
            }) { (_) in
                UIView.animate(withDuration: self.duration, delay: self.duration, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.image.transform = .identity
                })
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

