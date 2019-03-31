//
//  APIClient.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClient {
    func request<Resource: APIResource>(resource: Resource, completionHandler: @escaping (Result<Resource.ResponseModel>) -> Void)
}

class APIClientImplementation: APIClient {
    //    Alamofire
    //    .request(urlString,
    //    method: methodType,
    //    parameters: resource.parameters,
    //    encoding: JSONEncoding.default,
    //    headers: resource.headers)
    func request<Resource: APIResource>(resource: Resource, completionHandler: @escaping
        (Result<Resource.ResponseModel>) -> Void)  {
        
        guard let urlString = resource.urlString else { return }
        guard let methodType = HTTPMethod(rawValue: resource.type.rawValue) else { return }
        
        Alamofire.request(urlString).validate()
            .validate()
            .responseData { response in
                
                guard response.result.isSuccess else {
                    
                    if let error = response.error {
                        
                        print("Alamofire Error: \(error.localizedDescription)")
                        
                        let jobFinderError = JobFinderError(code: JobFinderErrorCode.unkownError.rawValue,
                                                            englishDesc: error.localizedDescription,
                                                            arabicDesc: error.localizedDescription)
                        
                        completionHandler(Result.failure(jobFinderError))
                        
                    }
                    return
                }
                
                if let value = response.result.value  {
                    let responseModel = resource.createModel(from: value)
                    completionHandler(Result.success(responseModel))
                    
                }else {
                    completionHandler(Result.failure(JobFinderError(code: JobFinderErrorCode.unkownError.rawValue, englishDesc: "", arabicDesc: "")))
                    
                }
            }
        
    }
    
}
