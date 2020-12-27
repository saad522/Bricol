//
//  Post.swift
//  Bricol
//
//  Created by mac on 12/27/20.
//

import Foundation
struct Post: Hashable {
    let Max          : String
    let Min          : String
    let about        : String
    let userId       : String
    let imageOne     : String
    let imageTwo     : String
    let imageTree    : String
    let imageFour    : String
    let isNegotiable : Bool
    let postID       : String
    let phoneNumber  : String
    let lookingFor   : String
    
   
    init(dectionary : [String : Any]) {
        self.Max          = dectionary["Max"]          as? String ?? ""
        self.Min          = dectionary["Min"]          as? String ?? ""
        self.about        = dectionary["about"]        as? String ?? ""
        self.userId       = dectionary["userId"]       as? String ?? ""
        self.imageOne     = dectionary["imageOne"]     as? String ?? ""
        self.imageTwo     = dectionary["imageTwo"]     as? String ?? ""
        self.imageTree    = dectionary["imageTree"]    as? String ?? ""
        self.imageFour    = dectionary["imageFour"]    as? String ?? ""
        self.isNegotiable = dectionary["isNegotiable"] as? Bool   ?? false
        self.postID       = dectionary["postID"]       as? String ?? ""
        self.phoneNumber  = dectionary["phoneNumber"]  as? String ?? ""
        self.lookingFor   = dectionary["lookingFor"]   as? String ?? ""
    }
}
