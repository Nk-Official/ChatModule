//
//  DocumentDirectoryManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation

open class DocumentDirectoryManager{
    
    func getData(from url: URL)->Data?{
        do{
            let data = try Data(contentsOf: url)
            return data
        }catch{
            print("error while fetching fata from url",error.localizedDescription)
            return nil
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getAppAlbum() -> URL {
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
    static func deleteFileAtUrl(localFile url: URL){
        let path = url.path
       do{
           try FileManager.default.removeItem(atPath: path)
           print("file at url",path,"\ndeleted successfully")
       }
       catch(let err){
           print("error while deleting file at url",path,err.localizedDescription)
       }
    }
    func getFilesAtPath(url: URL)->[URL]{
        
        let fileManager = FileManager.default
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            return fileURLs
        }
        catch{
            print("Error while enumerating files \(url.path): \(error.localizedDescription)")
            return []
        }
    }
}
