//
//  TheMovieDBStructures.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

struct Movies:Decodable {
    let page:Int
    let total_results:Int32
    let total_pages:Int32
    let results:[Movie]
}


struct Movie:Decodable {
    let vote_count:Int32
    let id:Int32
    let video:Bool
    let vote_average:Double
    let title:String
    let popularity:Double
    let poster_path:String
    let original_language:String
    let original_title:String
    let genre_ids:[Int32] = []
    let backdrop_path:String
    let adult:Bool
    let overview:String
    let release_date:String
}
