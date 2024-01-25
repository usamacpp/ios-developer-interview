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

    @Published var state: State = .empty(withError: .emptyQuery)
    @Published var errorColorCode: Color = .clear
    
    private var cancellables = Set<AnyCancellable>()
    
    func search(withText: String) {
        cancellables.removeAll()
        
        print("search for:", withText)
        
        API.shared.fetchWord(query: withText)
            .receive(on: DispatchQueue.main)
            .sink { res in
                switch res {
                case .finished:
                    print("finished")
                    self.errorColorCode = Color.clear
                case .failure(let err):
                    print("error:", err)
                    self.state = State.empty(withError: err)
                    
                    switch err {
                    case .tooShort(_):
                        self.errorColorCode = Color.yellow
                    case .emptyQuery:
                        self.errorColorCode = .clear
                    default:
                        self.errorColorCode = .clear
                    }
                }
            } receiveValue: { data in
                print("data:", data)
                self.state = .word(data.first!.word)
            }.store(in: &cancellables)
    }
}
