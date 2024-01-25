//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import Combine

class API: NSObject {
    public static let shared = API()
    private let session = URLSession.shared
    
    func fetchWord(query: String) -> AnyPublisher<[WordResponse], APIError> {
         guard !query.isEmpty else {
             return Fail(error: APIError.emptyQuery).eraseToAnyPublisher()
         }
         
         guard query.count > 2 else {
             return Fail(error: APIError.tooShort(query)).eraseToAnyPublisher()
         }
         
         let requestURL = URLBuilder(word: query.lowercased()).requestURLDict
         
         guard let url = URL(string: requestURL) else {
             return Fail(error: APIError.badURL).eraseToAnyPublisher()
         }
         
         print("Fetching from: ", url.absoluteString)
         
         return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                    throw APIError.custom(response.description)
                }
                
                if data.isEmpty {
                    throw APIError.noData
                }
                
                return data
            }
            .mapError { err in
                APIError.custom(err.localizedDescription)
            }
            .decode(type: [WordResponse].self, decoder: JSONDecoder())
            .mapError { err in
                APIError.custom(err.localizedDescription)
            }
            .eraseToAnyPublisher()
     }
}
