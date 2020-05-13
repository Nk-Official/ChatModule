//
//  Constants.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import FirebaseAuth

struct CommonFunctions {
    
    static func loginUserUdId()->String{
        guard let currentUser = Auth.auth().currentUser else{
            fatalError("firebase login missing")
        }
        return currentUser.uid
    }
    static func dictionaryDecode<T:Codable>(dictionary : Dictionary<AnyHashable, Any>)->T?{
        
        print(dictionary)
        do {
            let json = try JSONSerialization.data(withJSONObject: dictionary)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedModel = try decoder.decode(T.self, from: json)
            return decodedModel
        } catch {
            fatalError(error.localizedDescription)
            return nil
        }
    }
}
