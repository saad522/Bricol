//
//  ServiceDatabase.swift
//  Bricol
//
//  Created by mac on 12/27/20.
//
 

import Firebase
import FirebaseFirestore

class ServiceDatabase {
    static let shared = ServiceDatabase()
    let db = Firestore.firestore()
    lazy var collection = db.collection(DB_Keys.postsCollectionKey)
    
    func fetchUsersData(completion : @escaping([Post]?,Error?)->Void) {
       
        collection.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error : ",error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            
        let post = documents.map { (snpashot) -> Post in
                let dectionary = snpashot.data()
                return Post(dectionary: dectionary)
            }
            completion(post,nil)
        }
   }
    
    
    
    
    
}
