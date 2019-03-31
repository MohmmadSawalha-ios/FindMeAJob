//
//  ErrorCode.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

class JobFinderError {
    init(code: Int, englishDesc: String, arabicDesc: String) {
        self.code = code
        self.englishDesc = englishDesc
        self.arabicDesc = arabicDesc
    }
    convenience init(json: JSONDictionary) {
        if let errorCode = json["ErrorCode"] as? Int {
            let englishDesc = (json["ErrorEDesc"] as? String) ?? ""
            let arabicDesc = (json["ErrorADesc"] as? String) ?? ""
            self.init(code: errorCode, englishDesc: englishDesc, arabicDesc: arabicDesc)
        } else {
            self.init(code: JobFinderErrorCode.success.rawValue, englishDesc: "", arabicDesc: "")
        }
    }
    
    var code: Int
    
    private var arabicDesc: String
    
    private var englishDesc: String
    
    var localizedDescription: String {
        return  (Language.currentLanguage == .en) ? (englishDesc) : (arabicDesc)
    }
    var error: JobFinderErrorCode {
        guard let err = JobFinderErrorCode(rawValue: code) else { return .unkownError }
        return err
    }
}
enum JobFinderErrorCode: Int {
    case success  = 0
    case cantProccess = 750
    case unkownError = 1000
}
