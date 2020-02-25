//
//  CustomError.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
enum CustomError: LocalizedError{
    
    case unknownError
    case custom( String)
    var errorDescription: String?{
        switch self {
        case .unknownError:
            return "Unknown Error"
        case .custom(let error):
            return error
        }
    }
}
