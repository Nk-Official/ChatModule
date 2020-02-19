//
//  StoryBoards.swift
//  DosaApp
//
//  Created by Namrata Khanduri on 06/12/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
import UIKit
enum Storyboards: String {
    
    case main = "ChatModule"
    case example = "Example"
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewcontrollerClass: T.Type) -> T {
        let storyBoardId = (viewcontrollerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardId) as! T
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func initiatefromStoryboard(_ storyboard: Storyboards) -> Self {
        return storyboard.viewController(viewcontrollerClass:self)
    }
}
