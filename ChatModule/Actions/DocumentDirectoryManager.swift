//
//  DocumentDirectoryManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation

class DocumentDirectoryManager{
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getFileURL(name : String, typeExtension : String) -> URL {
        let path = getDocumentsDirectory().appendingPathComponent(name+typeExtension)
        return path as URL
    }
    
    func deleteFileFromDirectory(name : String, typeExtension : String){
        let path = getFileURL(name: name, typeExtension: typeExtension).path
        do{
            try FileManager.default.removeItem(atPath: path)
            print("file at url",path,"\ndeleted successfully")
        }
        catch(let err){
            print("error while deleting file at url",path,err.localizedDescription)
        }
    }
}
