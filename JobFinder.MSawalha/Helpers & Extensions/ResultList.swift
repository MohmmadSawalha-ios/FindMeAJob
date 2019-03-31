//
//  RsultList.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
enum Result<Value> {
    
    case success(Value)
    
    case failure(JobFinderError)
    
}
