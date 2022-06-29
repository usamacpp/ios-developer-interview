//
//  Word.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct Word: Codable {
    var text: String
    var definitions: [String]
    
    
//    static func parseData(_ data: Data) -> Word {
//        var word: Word = Word()
//
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
//
//            for dict in json {
//                if let meta = dict["meta"] as? [String: Any] {
//                    if let id: String = meta["id"] as? String{
//                        word.text = id
//                    }
//                }
//                if let definitions = dict["shortdef"] as? [String] {
//                    word.definitions = definitions
//                }
//            }
//
//        } catch {
//            print("PARSING ERROR: ", error.localizedDescription)
//        }
//        return word
//    }
}
