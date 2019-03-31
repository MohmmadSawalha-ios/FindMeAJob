//
//  InfoPlistManager.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

final class InfoPlistHelper {
    static var gitUrl: String? {
        // Getting info plist as a dictionary
        let dictionary = Bundle.main.infoDictionary
        guard let plist = dictionary else { return nil}
        guard let BaseURL = plist["BaseURLGit"] as? String else { return nil}
        guard let testURL = plist["TestURLGit"] as? String else { return nil}
        #if DEVELOP
        return testURL
        #elseif PRODCTN
        return BaseURL
        #else
        return testURL
        #endif
   }
    static var govUrL: String? {
        // Getting info plist as a dictionary
        let dictionary = Bundle.main.infoDictionary
        guard let plist = dictionary else { return nil}
        guard let BaseURL = plist["BaseURLGov"] as? String else { return nil}
        guard let testURL = plist["TestURLGov"] as? String else { return nil}
        #if DEVELOP
        return testURL
        #elseif PRODCTN
        return BaseURL
        #else
        return testURL
        #endif
    }
}
