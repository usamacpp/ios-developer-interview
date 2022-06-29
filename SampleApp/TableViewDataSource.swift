//
//  TableViewDataSource.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import UIKit


class TableViewDataSource: NSObject {
    
    enum State {
        case empty
        case word(Word)
    }

    var state: State
    init(state: State) {
        self.state = state
    }
    
    func updateState(_ state: State, completion: @escaping () -> ()) {
        self.state = state
        DispatchQueue.main.async {
            completion()
        }
    }
}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case let State.word(word) = state  else {
            return 0
        }
        return word.definitions.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let State.word(word) = state  else {
            return UITableViewCell()
        }
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        if indexPath.row == 0 {
            cell.textLabel?.text = "word:"
            cell.detailTextLabel?.text = word.text
        } else {
            cell.textLabel?.text = "definition:"
            cell.detailTextLabel?.text = word.definitions[indexPath.row - 1]
        }
        return cell
    }
}
