//
//  UIStoryboard+Loader.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import UIKit

 enum Storyboard : String {
    case main = "Main"
}
 enum ControllersName : String {
    case dashboardViewController = "DashboardVC"
    case detailsViewController = "DetailsVC"
}

extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}
