//
//  TheMovieDBStructures.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

struct MoviesServiceList:Decodable {
    let page:Int
    let total_results:Int32
    let total_pages:Int32
    let results:[MovieItem]
}


struct MovieItem:Decodable {
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
    let backdrop_path:String?
    let adult:Bool
    let overview:String
    let release_date:String
}


struct MovieGenre:Decodable {
    let id:Int32
    let name:String
}


struct ProductionCompanies:Decodable {
    let id:Int32
    let name:String
    let logo_path:String?
    let origin_country:String
}


struct MovieDetail:Decodable {
    let budget:Double
    let genres:[MovieGenre]
    let homepage:String
    let imdb_id:String
    let production_companies:[ProductionCompanies]
    let revenue:Double
    let tagline:String
    let status:String
    let runtime:Double
}


struct MovieCast:Decodable {
    let cast_id:Int32
    let character:String
    let credit_id:String
    let gender:Int
    let id:Int32
    let name:String
    let profile_path:String?
}


struct MovieCrew:Decodable {
    let department:String
    let credit_id:String
    let job:String
    let name:String
    let gender:Int
    let profile_path:String?
}


struct MovieCredits:Decodable {
    let cast:[MovieCast]
    let crew:[MovieCrew]
}
