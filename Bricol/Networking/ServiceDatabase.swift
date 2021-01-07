//
//  ServiceDatabase.swift
//  Bricol
//
//  Created by mac on 12/27/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class ServiceDatabase {
    var listener : ListenerRegistration?
    static let shared = ServiceDatabase()
    let db = Firestore.firestore()
    lazy var postCollection   = db.collection(DB_Keys.postsCollectionKey)
    lazy var userCollection   = db.collection(DB_Keys.usersCollectionKey)
    lazy var reviewCollection = db.collection(DB_Keys.reviewCollectionKey)

    
    
    func fetchHandyManReview(handymanID : String ,completion : @escaping  ([Reviews]?,Error?) -> Void)  {
        
        reviewCollection.whereField("handymanID", isEqualTo: handymanID).addSnapshotListener { (querySnapshot, error) in
            
            if let error = error {
                completion(nil,error)
                return
            }

              
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                
                let reviews = documents.compactMap { (snpashot) -> Reviews in
                    let dectionary = snpashot.data()
                    return Reviews(dectionary: dectionary)
                }
                completion(reviews,nil)
            
            
            
            
        }
        
    }
    func fetchAllUserPosts(completion : @escaping (Result<[String],Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        postCollection.whereField("userID", isEqualTo: userID).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let documents = querySnapshot?.documents else { return }
            let ids = documents.map { (snpashot) -> String in
                return snpashot.documentID
            }
            completion(.success(ids))
        }
    }
    
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
    func fetchHandymanInfo(city : String,metier : String, completion : @escaping([User]?,Error?)->Void) {
        userCollection
            .whereField("city", isEqualTo: city)
            .whereField("isClient", isEqualTo: 0)
            .whereField("metier", isEqualTo: metier)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print("Error : ",error.localizedDescription)
                    completion(nil,error)
                    return
                }
                guard let documents = querySnapshot?.documents else { return }
                let user = documents.map { (snpashot) -> User in
                    let dectionary = snpashot.data()
                    return User(dectionary: dectionary)
                }
                completion(user,nil)
            }
    }
    
    func fetchUserID(completion : @escaping(String?,Error?)->Void) {
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
                completion(user.userId,nil)
            }
            
        }
    }
}
