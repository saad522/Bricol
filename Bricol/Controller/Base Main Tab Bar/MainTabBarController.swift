//
//  MainTabBarController.swift
//  Bricol
//
//  Created by mac on 12/22/20.
//

import SwiftUI


class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setFunctions()
    }
    
}

//MARK: Setup TabarFunctions
extension MainTabBarController {
    fileprivate func setFunctions() {
        viewControllers = [
            setControllers(HomeViewControllert(), "Home", SFSymbols.house),
            setControllers(IndustryViewController(), "Offres", SFSymbols.flame)
        ]
    }
    fileprivate func setControllers(_ viewController : UIViewController, _ title : String,_ icon : String) -> UIViewController {
        let controller =  UINavigationController(rootViewController: viewController)
        controller.tabBarItem.title = title
        viewController.navigationItem.title = title
         controller.navigationBar.prefersLargeTitles = true
        controller.tabBarItem.image = UIImage(systemName: icon)
        UITabBar.appearance().tintColor = UIColor(Color.buttonsColor)
        return controller
        
    }
 
    
}
