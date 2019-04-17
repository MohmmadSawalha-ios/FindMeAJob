//
//  FetchService.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
struct FetchService: APIResource {
    var provider: ApiProvider
}

extension FetchService {
    var type: RestMethod {
        return .get
    }
    
    var parameters: JSONDictionary  {
        return ["":""]
    }
    
    var headers: HTTPHeaders {
        return ["": ""]
    }

    var urlString: String? {
        return provider.url
    }
    func createModel(from json: Data) -> [ConfigurableJob]? {
        var jobs: [ConfigurableJob] = []
        switch provider {
        case .git:
            guard let model =  json.decode(to: JobsGit.self) else { return nil }
             jobs = model
        case .gov:
            guard let model =  json.decode(to: JobsGov.self) else { return nil }
             jobs = model
        default:
            return nil
        }
        return jobs
    }
}
