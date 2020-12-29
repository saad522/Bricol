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
    lazy var postCollection = db.collection(DB_Keys.postsCollectionKey)
    lazy var userCollection = db.collection(DB_Keys.usersCollectionKey)
    func fetchPostsData(industry : String,completion : @escaping([Post]?,Error?)->Void) {
       
        postCollection.whereField("lookingFor", isEqualTo: industry).addSnapshotListener { (querySnapshot, error) in
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

    func fetchUserInfo(completion : @escaping(User?,Error?)->Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        userCollection.whereField("userId", isEqualTo: userID).getDocuments { (snpashot, error) in
            if let error = error {
                print("DEBUG: Failed Reason : ",error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let documents = snpashot?.documents else { return }
            for document in documents {
                let dictionary = document.data()
                let user = User(dectionary: dictionary)
                completion(user,nil)
            }
            
        }
    }
}
