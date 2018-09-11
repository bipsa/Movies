//
//  TheMovieDB.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import Foundation
import Alamofire


final class TheMovieDB:ApiService {

    
    static let api : TheMovieDB = {
        let instance = TheMovieDB()
        return instance
    }()
    
    
    
    /// Gets popular movies
    ///
    /// - Parameters:
    ///   - page: page you want to request
    ///   - complete: complete handler
    func getPopularMovies(page:Int = 1, complete: @escaping (_ error:ApiError?, _ movies:MoviesServiceList?) -> Void) {
        let params:[String:Any] = [
            "api_key": THEMOVIEDB_APIKEY,
            "page": page,
            "language": "en-US".localized
        ]
        self.request(service:Service(url:"\(THEMOVIEDB_APIURL_BASE)movie/popular", method:.get, headers:nil), params: params) { (error, response, data) in
            if let data:Data = data {
                do {
                    let movies = try JSONDecoder().decode(MoviesServiceList.self, from: data)
                    complete(nil, movies)
                } catch let parsingError {
                    print(parsingError)
                    complete(.noValidResponse, nil)
                }
            } else {
                complete(.noValidResponse, nil)
            }
        }
    }
    
    
    
}
