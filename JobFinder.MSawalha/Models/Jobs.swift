//
//  Jobs.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

typealias JobsGit = [JobGit]
typealias JobsGov = [JobGov]


struct ProvidersJobs {
    var git: [JobGit]
    var gov: [JobGov]

}

protocol ConfigurableJob{
    var companyURL: String? { get }
    var logo: String? { get }
    var jobTitle: String { get }
    var companyName: String? { get }
    var location: String? { get }
    var postDate: String? { get }
}


struct JobGit: Codable, ConfigurableJob {
    var id, type: String?
    var url: String?
    var postDate, companyName: String?
    var companyURL: String?
    var location: String?
    var description, howToApply: String
    var jobTitle: String
    var logo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, url
        case postDate = "created_at"
        case companyName = "company"
        case companyURL = "company_url"
        case location, description
        case jobTitle = "title"
        case howToApply = "how_to_apply"
        case logo = "company_logo"
    }
}


struct JobGov: Codable, ConfigurableJob{
    
    var logo: String? {
        return ""
    }
    
    var location: String?  {
        return locations.joined(separator: ",")
    }
    
    var jobTitle: String
    var id, companyName, rateIntervalCode: String?
    var minimum, maximum: Int?
    var  endDate: String?
    var postDate: String?
    var locations: [String]
    var companyURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case jobTitle = "position_title"
        case companyName = "organization_name"
        case rateIntervalCode = "rate_interval_code"
        case minimum, maximum
        case postDate = "start_date"
        case endDate = "end_date"
        case locations
        case companyURL = "url"
    }
}
