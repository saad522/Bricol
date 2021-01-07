//
//  Reviews.swift
//  Bricol
//
//  Created by mac on 1/7/21.
//

import Foundation



struct Reviews {
    let clinetID      : String
    let handymanID    : String
    let reviewID      : String
    let rate          : Int
    let review        : String
    let clientPicture : String
    let clientName    : String
    
    init(dectionary : [String : Any]) {
        self.clinetID      = dectionary["clientID"]       as? String ?? ""
        self.handymanID    = dectionary["handymanID"]     as? String ?? ""
        self.reviewID      = dectionary["reviewID"]               as? String ?? ""
        self.rate          = dectionary["ratin"]          as? Int ?? 1
        self.review        = dectionary["review"]         as? String ?? ""
        self.clientPicture = dectionary["clientPicture"]  as? String ?? ""
        self.clientName    = dectionary["clientName"]     as? String ?? ""
    }
}
