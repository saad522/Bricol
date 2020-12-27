//
//  ServiceStorage.swift
//  Bricol
//
//  Created by mac on 12/27/20.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class ServiceStorage {
    private init() {}
    
    static let shared = ServiceStorage()
    
    private let storage = Storage.storage()
    private lazy var imageReference = storage.reference().child("postImages")
    private let metaData = StorageMetadata()
    
    private let compression : CGFloat = 0.5
    
    
    func upload(_ image : UIImage , completion : @escaping (String?,Error?) -> ()) {
        guard let userPhoneNumber = Auth.auth().currentUser?.phoneNumber else { return }
        let uuid = UUID().uuidString
        let imagesPaths : String = "\(userPhoneNumber)/\(uuid).jpg"
        let imageRef = imageReference.child(imagesPaths)
         
        guard let imageData = image.jpegData(compressionQuality: compression) else { return }
        
        metaData.contentType = "image/jpg"
          
        imageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            if let error = error {

                completion(nil,error)
                return
            }
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                guard let imaeURL = url?.absoluteString else { return }
                completion(imaeURL,nil)
            }
        }
    }
    
    
    func uploadMutliImages(_ images : [UIImage], completion : @escaping ([String]?,Error?) -> Void) {
        
        var imagePaths = [String]()
        var counter = 0
        
        for image in images {
            upload(image) { (urlPath, error) in
                if let error = error {
                    completion(nil,error)
                    return
                }
                guard let imageURL = urlPath else { return }
                imagePaths.append(imageURL)
                counter += 1
                if counter == images.count {
                    completion(imagePaths,nil)
                } 
            }
        }
        
    }
}
