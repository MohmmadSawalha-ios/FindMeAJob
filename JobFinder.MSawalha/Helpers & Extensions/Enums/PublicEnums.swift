//
//  PublicEnums.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation



enum Language: String {
    case en
    case ar
    
    static var currentLanguage: Language {
        let preferredLanguage = Locale.preferredLanguages[0] as String
        return (preferredLanguage.contains("ar")) ? (.ar) : (.en)
    }
}

enum DateFormat: String {
    case DDMMYYSlashed = "dd/MM/yyyy"
    case DDMMYYDashed = "dd-MM-yyyy"
}


// to add new provider, add it in Info.plist First, then add the case, then simply return the url.
//TODO: create one function with arguemnt of rowValue to get the url.

struct ApiProvider: OptionSet {
    let rawValue: UInt8
    static let git = ApiProvider(rawValue: 1 << 0)
    static let gov = ApiProvider(rawValue: 1 << 1)
    var url: String? {
        switch self{
        case .git: return InfoPlistHelper.gitUrl
        case .gov: return InfoPlistHelper.govUrL
        // case [.gov, .git]: return [InfoPlistHelper.govUrL, InfoPlistHelper.gitUrl] TODO: handle multi flags for providers in APIClient.
        default:
            return ""
        }
    }
    static var segments: [String] {
        return ["Git", "Gov"]
    }
}

