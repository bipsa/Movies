//
//  TheMovieDB.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import Foundation
import Alamofire


final class TheMovieDB {

    static let api : TheMovieDB = {
        let instance = TheMovieDB()
        return instance
    }()
    
    
    
    /// Common request method
    ///
    /// - parameter service:  service param
    /// - parameter params:   params from the request
    /// - parameter complete: complete handler
    private func request(service:Service, params:[String: Any]?, complete: @escaping (_ error:ApiError?, _ response:Any?, _ data:Data?) -> Void) {
        var encoding:ParameterEncoding = JSONEncoding.default
        if service.method == .get {
            encoding = URLEncoding.default
        }
        Alamofire.request(service.url, method: service.method, parameters: params, encoding:encoding, headers:service.headers).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value {
                    complete(nil, result, response.data)
                } else {
                    complete(.noValidResponse, nil, response.data)
                }
            case .failure:
                complete(.serverError, nil, response.data)
            }
        }
    }
    
    
    
    func getPopularMovies(page:Int = 1, complete: @escaping (_ error:ApiError?, _ movies:Movies?) -> Void) {
        let params:[String:Any] = [
            "api_key": THEMOVIEDB_APIKEY,
            "page": page,
            "language": "en-US".localized
        ]
        self.request(service:Service(url:"\(THEMOVIEDB_APIURL_BASE)movie/popular", method:.get, headers:nil), params: params) { (error, response, data) in
            if let data:Data = data {
                do {
                    let movies = try JSONDecoder().decode(Movies.self, from: data)
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
