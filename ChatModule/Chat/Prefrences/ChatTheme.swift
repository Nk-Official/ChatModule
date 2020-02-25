//
//  ChatTheme.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit

enum ChatTheme: String{
    
    case whatsappTheme, theme2, defaultTheme
    
    var incoming_bubbleTextColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIColor.black
        case .theme2:
            return UIColor.white
        }
    }
    var incoming_bubbleBackGroundColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIColor.white
        case .theme2:
            return #colorLiteral(red: 0.3130034804, green: 0.5957725048, blue: 0.6281011701, alpha: 1)
        }
    }
    var incoming_bubbleBorderColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIColor.white
        case .theme2:
            return #colorLiteral(red: 0.3130034804, green: 0.5957725048, blue: 0.6281011701, alpha: 1)
        }
    }
    var incoming_bubbleTimeLblColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIColor.lightGray
        case .theme2:
            return UIColor.white.withAlphaComponent(0.4)
        }
    }
    
    
    
    
    var outgoing_bubbleTextColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIColor.black
        case .theme2:
            return UIColor.white
        }
    }
    var outgoing_bubbleBackGroundColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return #colorLiteral(red: 0.7720106244, green: 0.8764387369, blue: 0.6960803866, alpha: 1)
        case .theme2:
            return #colorLiteral(red: 0.12543419, green: 0.3694596887, blue: 0.4324318767, alpha: 1)
        }
    }
    var outgoing_bubbleBorderColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return #colorLiteral(red: 0.7720106244, green: 0.8764387369, blue: 0.6960803866, alpha: 1)
        case .theme2:
            return #colorLiteral(red: 0.12543419, green: 0.3694596887, blue: 0.4324318767, alpha: 1)
        }
    }
    var outgoing_bubbleTimeLblColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIColor.lightGray
        case .theme2:
            return UIColor.white.withAlphaComponent(0.4)
        }
    }
    
    
    
    var chatBackgroundColor : UIColor{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return #colorLiteral(red: 0.8011385202, green: 0.7792908549, blue: 0.7574980259, alpha: 1)
        case .theme2:
            return #colorLiteral(red: 0.01501366869, green: 0.1499375403, blue: 0.1867240965, alpha: 1)
        }
    }
    var chatBackgroundImage : UIImage?{
        switch self{
        case .whatsappTheme,.defaultTheme:
            return UIImage(named: "whatsappChatBG")
        case .theme2:
            return nil
        }
    }
}

