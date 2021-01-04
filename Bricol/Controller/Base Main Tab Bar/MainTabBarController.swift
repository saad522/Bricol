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
        let hostingController = UIHostingController(rootView: ProfileViewController())
        
        viewControllers = [
            setControllers(HomeViewControllert(), "Home", SFSymbols.house),
            setControllers(IndustryViewController(), "Offres", SFSymbols.flame),
            setControllersWithoutNavigationBar(hostingController, "Profile", "rectangle.stack.person.crop")
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
 
    fileprivate func setControllersWithoutNavigationBar(_ viewController : UIViewController, _ title : String,_ icon : String) -> UIViewController {
        let controller =   viewController
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: icon)
        UITabBar.appearance().tintColor = UIColor(Color.buttonsColor)
        return controller
        
    }
}
