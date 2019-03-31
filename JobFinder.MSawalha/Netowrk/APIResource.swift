//
//  APIResource.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias HTTPHeaders = [String: String]

protocol APIResource {
    
    associatedtype ResponseModel
    
    
    var parameters: JSONDictionary { get }
    
    func createModel(from json: Data) -> ResponseModel
    
    var type: RestMethod { get }
    
    var headers: HTTPHeaders { get }
    
    var urlString: String? { get }
}

extension APIResource {
    
    var parameters: JSONDictionary {
        return [:]
    }
}

    enum RestMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
