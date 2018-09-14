//
//  Genre+Extension.swift
//  Movies
//
//  Created by Sebastian Romero on 14/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

extension Genre {
    
    
    class func add(genreItem:MovieGenre) -> Genre {
        var genre:Genre! = Genre.get(attribute: "id", value: "=\(genreItem.id)")
        if genre == nil {
            genre = Genre.create()
        }
        genre.id = genreItem.id
        genre.name = genreItem.name
        _ = genre.save()
        return genre
    }
    
}
