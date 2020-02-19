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
    
    init() {
        imageRefrence = storageRefrence.child("images")
        audioRefrence = storageRefrence.child("audios")
    }
    @discardableResult
    func uploadAudio(localfile url: URL, completion : @escaping (Result<URL,Error>)->()) -> StorageUploadTask{
        let metadata = StorageMetadata()
        metadata.contentType = "audio/mpeg"
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = audioRefrence.putFile(from: url, metadata: metadata) { metadata, error in
              guard let metadata = metadata else {
                completion(.failure(error ?? CustomError.unknownError ))
                return
              }
          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
            print("file type",metadata.contentType as Any)
          // You can also access to download URL after upload.
            self.audioRefrence.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error ?? CustomError.unknownError))
                    return
                }
                completion(.success(downloadURL))
             }
        }
        
        return uploadTask
    }
    
    @discardableResult
    func uploadImage(image : UIImage, completion : @escaping (Result<URL,Error>)->()) -> StorageUploadTask?{
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        if let data = image.pngData(){
            let task = imageRefrence.putData(data, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  completion(.failure(error ?? CustomError.unknownError ))
                  return
                }
                self.imageRefrence.downloadURL { (url, error) in
                   guard let downloadURL = url else {
                       completion(.failure(error ?? CustomError.unknownError))
                       return
                   }
                   completion(.success(downloadURL))
                }
            }
            return task
        }
        completion(.failure(CustomError.custom("Image Format not supported")))
        return nil
    }
}


private enum CustomError: LocalizedError{
    
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
