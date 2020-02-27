//
//  FirebaseStorageManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 14/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import FirebaseStorage

struct FirebaseStorageManager {
    
    let storageRefrence = Storage.storage().reference()
    let imageRefrence : StorageReference
    let audioRefrence : StorageReference
    let contactsRefrence : StorageReference
    let filesRefrence : StorageReference

    init() {
        imageRefrence = storageRefrence.child("images")
        audioRefrence = storageRefrence.child("audios")
        contactsRefrence = storageRefrence.child("contact")
        filesRefrence = storageRefrence.child("files")

    }
    @discardableResult
    func uploadAudio(localfile url: URL, completion : @escaping (Result<URL,Error>)->()) -> StorageUploadTask{
        let metadata = StorageMetadata()
        metadata.contentType = "audio/mpeg"
        // Upload the file to the path "images/rivers.jpg"
        
        let uploadTask = uploadData(storageRefrence: audioRefrence, name: url.lastPathComponent, fileurl: url, metadata: metadata, completion: completion)
        
        return uploadTask
    }
    
    @discardableResult
    func uploadImage(image : UIImage, completion : @escaping (Result<URL,Error>)->()) -> StorageUploadTask?{
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        if let data = image.pngData(){
            let name = String(Int.random(in: 0 ... 1000)) + ".png"
            let task = self.uploadData(storageRefrence: imageRefrence, name: name, data: data, metadata: metadata,completion: completion)
            return task
        }
        completion(.failure(FireBasemanagerError.custom("Image Format not supported")))
        return nil
    }
    
    @discardableResult
    func uploadContactData(data: Data, completion : @escaping (Result<URL,Error>)->())  -> StorageUploadTask?{
        
        let name = String(Int.random(in: 0 ... 1000))
        return uploadData(storageRefrence: contactsRefrence, name: name, data: data, metadata: nil, completion: completion)
    }
    @discardableResult
    func uploadFileData(fileat url: URL, completion : @escaping (Result<URL,Error>)->())  -> StorageUploadTask?{
        
        let fileExtension = url.pathExtension
        let name = url.lastPathComponent
        let metadata = StorageMetadata()
        metadata.contentType = "file/"+fileExtension
        
        return uploadData(storageRefrence: filesRefrence, name: name, fileurl: url, metadata: metadata, completion: completion)
    }
    
    
    private func uploadData(storageRefrence: StorageReference,name: String,data: Data, metadata: StorageMetadata?,completion: @escaping ((Result<URL,Error>)->()))->StorageUploadTask{
        let refrence = storageRefrence.child(name)
        let task = refrence.putData(data, metadata: metadata) { (_, error) in
            if error != nil{
                completion(.failure(error!))
                return
            }
            refrence.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error ?? FireBasemanagerError.unknownError))
                    return
                }
                completion(.success(downloadURL))
            }
        }
        
        return task
    }
    private func uploadData(storageRefrence: StorageReference,name: String,fileurl: URL, metadata: StorageMetadata?,completion: @escaping ((Result<URL,Error>)->()))->StorageUploadTask{
        let refrence = storageRefrence.child(name)
    
        let uploadTask = refrence.putFile(from: fileurl, metadata: metadata) { metadata, error in
              guard let metadata = metadata else {
                completion(.failure(error ?? FireBasemanagerError.unknownError ))
                return
              }
          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
            print("file type",metadata.contentType as Any)
          // You can also access to download URL after upload.
            refrence.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error ?? FireBasemanagerError.unknownError))
                    return
                }
                completion(.success(downloadURL))
             }
        }
        return uploadTask
    }
}


private enum FireBasemanagerError: LocalizedError{
    
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
