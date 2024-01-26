//
//  DataSource.swift
//  SampleApp2
//
//  Created by ossama mikhail on 1/21/24.
//

import SwiftUI
import Combine

class DataSource: ObservableObject {
    
    enum State {
        case empty(withError: APIError)
        case word(Word)
    }

    @Published var state: State {
        didSet {
            switch state {
            case .empty(let err):
                switch err {
                case .tooShort(_):
                    errorColorCode = Color.yellow
                default:
                    errorColorCode = Color.clear
                }
            default:
                errorColorCode = Color.clear
            }
        }
    }
    @Published private(set) var errorColorCode = Color.clear
    
    private var cancellables = Set<AnyCancellable>()
    
    init(state: State) {
        self.state = state
    }
    
    func search(withText: String) {
        cancellables.removeAll()
        
        print("search for:", withText)
        
        API.shared.fetchWord(query: withText)
            .receive(on: DispatchQueue.main)
            .sink { res in
                if case .failure(let err) = res {
                    print("error:", err)
                    self.state = State.empty(withError: err)
                }
            } receiveValue: { data in
                print("data:", data)
                self.state = .word(data.first!.word)
            }.store(in: &cancellables)
    }
}
