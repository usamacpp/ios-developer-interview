//
//  DataSource.swift
//  SampleApp2
//
//  Created by ossama mikhail on 1/21/24.
//

import SwiftUI
import Combine

enum DataSourceState {
    case empty(withError: APIError)
    case word(Word)
}

protocol DataSourceProtocol {
    var api: APIProtocol { get }
    
    init(state: DataSourceState, api: APIProtocol)
    func search(withText: String)
}

class DataSource: ObservableObject, DataSourceProtocol {
    
    let api: APIProtocol
    
    @Published var state: DataSourceState {
        didSet {
            switch state {
            case .empty(let err):
                switch err {
                case .tooShort(_):
                    errorColorCode = Color.yellow
                case .noData, .custom(_), .badURL, .responseDecodeFailed:
                    errorColorCode = Color.red
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
    
    required init(state: DataSourceState = DataSourceState.empty(withError: .emptyQuery), api: APIProtocol = API.shared) {
        self.state = state
        self.api = api
    }
    
    func search(withText: String) {
        cancellables.removeAll()
        
        print("search for:", withText)
        
        api.fetchWord(query: withText)
            .receive(on: DispatchQueue.main)
            .sink { res in
                if case .failure(let err) = res {
                    print("error:", err)
                    self.state = DataSourceState.empty(withError: err)
                }
            } receiveValue: { data in
                print("data:", data)
                self.state = .word(data.first!.word)
            }.store(in: &cancellables)
    }
}
