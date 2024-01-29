//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case custom(String)
    case noData
    case emptyQuery
    case tooShort(String)
    case responseDecodeFailed
    
    var description: String {
        switch self {
        case .badURL: return "bad url"
        case .custom(let custom): return custom
        case .noData: return "no data"
        case .emptyQuery: return "empty query"
        case .tooShort(_): return "too short"
        case .responseDecodeFailed: return "response decode failed"
        }
    }
}
