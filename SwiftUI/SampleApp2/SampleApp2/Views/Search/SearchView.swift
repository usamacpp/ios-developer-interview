//
//  ContentView.swift
//  SampleApp2
//
//  Created by ossama mikhail on 1/21/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var dataSource = DataSource()
    @State private var textSearch: String = ""
    
    var body: some View {
        VStack {
            Text("Search in Merriam Webster Dictrionary")
            HStack {
                TextField("search word", text: $textSearch)
                    .padding(6)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                    .onSubmit {
                        submit()
                    }
                    .onChange(of: textSearch) { oldValue, newValue in
                        print("text changed", textSearch)
                        submit()
                    }.background(dataSource.errorColorCode)
                
                Button {
                    submit()
                } label: {
                    Text("Search").padding(6).background(Color.blue).foregroundColor(.white)
                }

            }
            
            if case let .word(wd) = dataSource.state {
                Text(wd.text)
            } else if case let .empty(err) = dataSource.state {
                Text("Error: " + err.description).dynamicTypeSize(.xSmall)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func submit() {
        dataSource.search(withText: textSearch)
    }
}

#Preview {
    SearchView()
}
