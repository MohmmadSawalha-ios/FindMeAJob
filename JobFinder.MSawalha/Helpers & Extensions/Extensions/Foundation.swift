//
//  Foundation.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
//MARK: Dictionary
extension Dictionary where Key == String {
    static func decode<T: Codable>(to model: T.Type) -> T? {
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: self,
            options: .prettyPrinted
            ),
            let jsonText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            guard let data = jsonText.data(using: .utf8) else { return nil}
            guard let model = try? JSONDecoder().decode(model, from: data) else { return nil}
            return model
        }
        return nil
    }
    
}
//MARK: Data
extension Data {
    func decode<T: Codable>(to model: T.Type) -> T? {
        guard let model = try? JSONDecoder().decode(model, from: self) else { return nil}
        return model
    }
    
}
//MARK: String
extension String {
    func toDate(using format: DateFormat) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "EE MMM dd HH:mm:ss zzz yyyy"
        
        let dateFormatterReturn = DateFormatter()
        dateFormatterReturn.dateFormat = format.rawValue
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterReturn.string(from: date)
        } else {
            return self // could not format
        }
    }
}


