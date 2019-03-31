//
//  FetchGateway.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

typealias fetchCallback =  (Result<ProvidersJobs?>) -> Void

protocol  JobFinderGateway{
    func fetch(service: FetchService, callback: @escaping fetchCallback)
}

class JobFinderGatewayImplementation: JobFinderGateway {
    private let apiClient: APIClient
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetch(service: FetchService, callback: @escaping fetchCallback) {
        apiClient.request(resource: service, completionHandler: callback)
    }
}
