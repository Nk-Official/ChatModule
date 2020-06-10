//
//  Bundle.swift
//  ChatModule
//
//  Created by user on 10/06/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
extension Bundle {
    var displayName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }
}
