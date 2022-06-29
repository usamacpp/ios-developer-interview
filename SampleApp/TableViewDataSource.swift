//
//  TableViewDelegate.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import UIKit


class TableViewDelegate: NSObject, UITableViewDelegate {
    
    let word: Word
    init(word: Word) {
        self.word = word
    }
}
