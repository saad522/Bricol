//
//  User.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import Foundation

class User: Hashable,ObservableObject {
    func hash(into hasher: inout Hasher) {
        print("")
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userId == rhs.userId
    }
    
    @Published var name         : String
    @Published var city         : String
    @Published var phone        : String
    @Published var userId       : String
    @Published var isClient     : Int
    @Published var pictureProfile : String?
    @Published var aboutMe      : String?
    @Published var metier       : String?
    @Published var review       : String?
    @Published var status       : Bool?
    @Published var work         : String?
    
    init(dectionary : [String : Any]) {
        self.name         = dectionary["name"] as? String ?? ""
        self.city         = dectionary["city"] as? String ?? ""
        self.userId       = dectionary["userId"] as? String ?? ""
        self.phone        = dectionary["phone"] as? String ?? ""
        self.isClient     = dectionary["isClient"] as? Int ?? 0
        self.aboutMe      = dectionary["aboutMe"] as? String ?? ""
        self.metier       = dectionary["metier"] as? String ?? ""
        self.review       = dectionary["review"] as? String ?? ""
        self.status       = dectionary["status"] as? Bool ?? false
        self.work         = dectionary["work"] as? String ?? ""
        self.pictureProfile = dectionary["pictureProfile"] as? String ?? ""
    }
}
