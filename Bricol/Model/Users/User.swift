//
//  User.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import Foundation

struct User: Hashable {
    let name         : String
    let city         : String
    let phone        : String
    let userId       : String
    let isClient     : Int
    var aboutMe      : String?
    var metier       : String?
    var review       : String?
    var status       : Bool?
    var work         : String?
    
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
    }
}
