//
//  Api.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import Foundation
import Alamofire


/// Defines the different error in the api wrapper
///
/// - serverError:       if the server raises and error
/// - notAllowed:        if the request is not allowed
/// - badRequest:        if the there is a bad request
/// - noValidResponse:   if there is not a valid response
/// - requestInProgress: if the request is currently performing another request
enum ApiError: Error {
    case serverError
    case notAllowed
    case badRequest
    case noValidResponse
    case requestInProgress
}


/// Defines the Service structure for the API
struct Service {
    /// Url to reach
    var url:String
    /// Service method, get method as default
    var method:HTTPMethod = .get
    /// Headers
    var headers: HTTPHeaders? = nil
}


class ApiService {
    
    
    /// Common request method
    ///
    /// - parameter service:  service param
    /// - parameter params:   params from the request
    /// - parameter complete: complete handler
    internal func request(service:Service, params:[String: Any]?, complete: @escaping (_ error:ApiError?, _ response:Any?, _ data:Data?) -> Void) {
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
    
}
