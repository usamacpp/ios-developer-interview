//
//  RequestBuilder.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct URLBuilder {
    
    
    var baseURL: String
    var word: String

    var URL: String {
        return baseURL + word + "?" + Tokens.apiKeyDict
    }
}
