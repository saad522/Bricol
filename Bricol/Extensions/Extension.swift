//
//  Extension.swift
//  iDelivery
//
//  Created by mac on 10/27/20.
//

import SwiftUI

//Circle For Colors
struct Alert {
    static func alerts(title : String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20).isActive = true
        
        return alert
    }
    
    static func showInteractiveAlert(_ on: UIViewController ,with title: String ,and message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
        on.present(alert, animated: true, completion: nil)
    }
}


extension Color {
    static let titlesColor = Color("Titles")
    static let buttonsColor = Color("Buttons")
}


extension UIView {
    convenience init(_ color : UIColor,_ size : CGFloat) {
        self.init(frame:.zero)
        self.backgroundColor = color
        self.constrainHeight(constant: size)
        self.constrainWidth(constant: size)
        self.layer.cornerRadius = size / 2
    }
}
extension UIButton {
    convenience init(_ size : CGFloat = 45,_ color : UIColor = .systemGray) {
        self.init(type: .custom)
        self.constrainHeight(constant: size)
        self.constrainWidth(constant: size)
        self.layer.cornerRadius = size / 2
        self.backgroundColor = color
    }
}
extension UIButton {
    convenience init(action : String,background : UIColor = .niceBlue) {
		self.init(type: .system)
		self.tintColor = .white
		self.setTitle(action, for: .normal)
		self.setTitleColor(.white, for: .normal)
		self.titleLabel?.font = .boldSystemFont(ofSize: 16)
		self.backgroundColor = background
		self.constrainHeight(constant: 40)
		self.constrainWidth(constant: 240)
		self.layer.cornerRadius = 5
	}
}
extension UIButton {
    convenience init(with icons: String) {
        self.init(type: .custom)
        self.tintColor = .label
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
        self.setImage(UIImage(systemName: icons, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}
extension UIButton {
	convenience init(_ icon: String,size : CGFloat = 35,color : UIColor = .systemGray) {
		self.init(type: .system)
		self.tintColor = color
		let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .light, scale: .large)
		self.setImage(UIImage(systemName: icon, withConfiguration: configuration)?.withRenderingMode(.alwaysTemplate), for: .normal)
	}
}
extension UIFont {
    static let verdana = UIFont(name: "Verdana-Bold", size: 30)!
    static let verdanaTitle = UIFont(name: "Verdana-Bold", size: 20)!
    static let verdanaLight = UIFont(name: "Verdana", size: 20)!
    static let verdanaMedium = UIFont(name: "Verdana", size: 25)!
    static let verdanaSmall = UIFont(name: "Verdana", size: 16)!
}
extension UILabel {
    convenience init(text: String, font: UIFont = .systemFont(ofSize: 16, weight: .semibold) , numberOfLines: Int = 1,textColor : Color = .black) {
		self.init(frame: .zero)
		self.text = text
		self.font = font
        self.textColor = UIColor(textColor)
		self.numberOfLines = numberOfLines
	}
}
extension UIView {
    func shadow(_ color : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4876884814)){
        layer.shadowOpacity = 0.3
        layer.shadowRadius  = 3
        layer.shadowOffset  = .init(width: 0, height: 6)
        layer.shadowColor   = color.cgColor
    }
}
extension UITextField {
	convenience init(placholder : String,isPassword : Bool = false) {
		self.init(frame : .zero)
        let fontName = UserDefaults.standard.string(forKey: Keys.fontsKeys) ?? "Thonburi"
		self.attributedPlaceholder = NSAttributedString(string: "\(placholder)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont(name: fontName, size: 19)!])
		self.borderStyle = .none
		self.isSecureTextEntry = isPassword
	}
}
extension UIImageView {
    convenience init(_ icone : String, size : CGFloat = 16,_ tintColor : UIColor = UIColor(Color.black)) {
		self.init(frame:.zero)
		self.image = UIImage(systemName: "\(icone)",withConfiguration: UIImage.SymbolConfiguration(pointSize: size, weight: .regular, scale: .large))?.withRenderingMode(.alwaysTemplate)
        self.tintColor = tintColor
	}
}
extension UIView {
	convenience init(_ color : UIColor = .lightGray) {
		self.init(frame:.zero)
		self.backgroundColor = color
		self.constrainHeight(constant: 1)
	}
}
extension UIView {
    convenience init(shadowOpacity : Float = 0.4,_ cornerRadius : CGFloat = 5,_ backgroundColor : UIColor = .systemBackground) {
		self.init(frame:.zero)
		self.layer.shadowOpacity = shadowOpacity
		self.layer.shadowRadius = 10
		self.layer.shadowOffset = .init(width: 0, height: 10)
		self.layer.cornerRadius = cornerRadius
		self.backgroundColor = backgroundColor
	}
}
extension UIImageView {
	convenience init(cornerRadius: CGFloat) {
		self.init(image: nil)
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
		self.contentMode = .scaleAspectFill
	}
}

extension UIButton {
	convenience init(title: String,_ backgroundColor : UIColor = .niceBlue,_ titlColor : UIColor = .white,_ size : CGFloat = 36) {
		self.init(type: .system)
		self.setTitle(title, for: .normal)
		self.setTitleColor(titlColor, for: .normal)
		self.titleLabel?.font = UIFont(name: "Avenir-Light", size: size)
		self.layer.cornerRadius = 5
		self.layer.shadowOpacity = 0.4
		self.layer.shadowRadius = 10
		self.layer.shadowOffset = .init(width: 0, height: 10)
		self.layer.cornerRadius = 5
		self.backgroundColor = backgroundColor
	}
}

extension UIButton {
    convenience init(_ message : String, _ action : String) {
		self.init(type: .system)
        let attribudeTitle = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray,NSAttributedString.Key.font : UIFont.verdanaSmall ])
		attribudeTitle.append(NSAttributedString(string: action, attributes:
                                                    [NSAttributedString.Key.foregroundColor : UIColor(Color.buttonsColor)
                                                     ,NSAttributedString.Key.font : UIFont.verdanaLight]))
		self.setAttributedTitle(attribudeTitle, for: .normal)
	}
}

extension UIColor {
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
		return .init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
	}
	
	static let logoColor = UIColor.rgb(red: 25, green: 25, blue: 25)
	static let niceBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
	static let systemColor = UIColor.init(red: 0.9489366412, green: 0.9490728974, blue: 0.9489069581, alpha: 1)
	static let greateBlue = UIColor.rgb(red: 74, green: 150, blue: 233)
	static let iosColor = UIColor.init(red: 0.9492425323, green: 0.9487358928, blue: 0.9704347253, alpha: 1)
	
}

//MARK: advanced  funcs from stackoverflow 🤓

extension UIImage {
	
	class func textEmbededImage(image: UIImage, string: String, color:UIColor, imageAlignment: Int = 0, segFont: UIFont? = nil) -> UIImage {
		let font = segFont ?? UIFont.systemFont(ofSize: 16.0)
		let expectedTextSize: CGSize = (string as String).size(withAttributes: [NSAttributedString.Key.font: font])
		let width: CGFloat = expectedTextSize.width + image.size.width + 5.0
		let height: CGFloat = max(expectedTextSize.height, image.size.width)
		let size: CGSize = CGSize(width: width, height: height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		let context: CGContext = UIGraphicsGetCurrentContext()!
		context.setFillColor(color.cgColor)
		let fontTopPosition: CGFloat = (height - expectedTextSize.height) / 2.0
		let textOrigin: CGFloat = (imageAlignment == 0) ? image.size.width + 5 : 0
		let textPoint: CGPoint = CGPoint.init(x: textOrigin, y: fontTopPosition)
		string.draw(at: textPoint, withAttributes: [NSAttributedString.Key.font: font])
		let flipVertical: CGAffineTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
		context.concatenate(flipVertical)
		let alignment: CGFloat =  (imageAlignment == 0) ? 0.0 : expectedTextSize.width + 5.0
		context.draw(image.cgImage!, in: CGRect.init(x: alignment, y: ((height - image.size.height) / 2.0), width: image.size.width, height: image.size.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
		
		return newImage!
	}
}
extension UIImage {
	func resized(to size: CGSize) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { _ in
			draw(in: CGRect(origin: .zero, size: size))
		}
	}
}

extension UserDefaults {
  func colorForKey(key: String) -> UIColor? {
    var colorReturnded: UIColor?
    if let colorData = data(forKey: key) {
      do {
        if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
          colorReturnded = color
        }
      } catch {
        print("Error UserDefaults")
      }
    }
    return colorReturnded
  }
  
  func setColor(color: UIColor?, forKey key: String) {
    var colorData: NSData?
    if let color = color {
      do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
        colorData = data
      } catch {
        print("Error UserDefaults")
      }
    }
    set(colorData, forKey: key)
  }
}

extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: Keys.stringKey) ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "Localizable")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: Keys.stringKey )
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}
extension String {
    var localized: String {
        if let _ = UserDefaults.standard.string(forKey: Keys.stringKey) {} else {
            // we set a default, just in case
            UserDefaults.standard.set("en", forKey: Keys.stringKey)
            UserDefaults.standard.synchronize()
        }

        let lang = UserDefaults.standard.string(forKey: Keys.stringKey)

        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
extension UIColor {

     class func color(data:Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        print(gradientLayer.frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}

extension UIImageView {
    convenience init(initialImage: UIImage, useContenMode: UIView.ContentMode) {
        self.init()
        image = #imageLiteral(resourceName: "Image")
        contentMode = .scaleAspectFit
    }
}
extension UIButton {
    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.99
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}
extension UIEdgeInsets {
    init(allInset: CGFloat) {
        self.init(top: allInset, left: allInset, bottom: allInset, right: allInset)
    }
}
