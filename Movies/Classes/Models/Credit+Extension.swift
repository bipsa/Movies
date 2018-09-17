//
//  Credit+Extension.swift
//  Movies
//
//  Created by Sebastian Romero on 17/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import Foundation


extension Credit {
    
    
    class func add(creditItem:MovieCast) -> Credit {
        var credit:Credit! = Credit.get(attribute: "id", value: "=\(creditItem.id)")
        if credit == nil {
            credit = Credit.create()
        }
        credit.castId = creditItem.cast_id
        credit.character = creditItem.character
        credit.creditId = creditItem.credit_id
        credit.gender = Int16(creditItem.gender)
        credit.id = creditItem.id
        credit.name = creditItem.name
        credit.profilePath = creditItem.profile_path
        _ = credit.save()
        return credit
    }
    
    
    var thumbnail:URL? {
        if let path = self.profilePath {
            if let finalURL:URL = URL(string: "https://image.tmdb.org/t/p/w200\(path)") {
                return finalURL
            }
        }
        return nil
    }
    
}
