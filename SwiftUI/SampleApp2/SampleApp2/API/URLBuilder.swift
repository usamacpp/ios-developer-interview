//
//  URLBuilder.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct URLBuilder {
    let word: String
    
    private static let baseUrlDict = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    private static let baseUrlThes = "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"

    var requestURLDict: String {
        let url = URLBuilder.baseUrlDict + word + "?key=" + Tokens.apiKeyDict
        return url
    }
    
    var requestURLThes: String {
        let url = URLBuilder.baseUrlThes + word + "?key=" + Tokens.apiKeyThes
        return url
    }
}
