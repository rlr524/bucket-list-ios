//
//  ContentView.swift
//  BucketList
//
//  Created by Rob Ranf on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingMap = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Read and Write") {
                let data = Data("Test Message".utf8)
                let url = URL.documentsDirectory.appending(path: "message.txt")
                
                do {
                    try data.write(to: url, options: [.atomic, .completeFileProtection])
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
                
                //getDirectory()
            }
            
            Spacer()
            
            Button("Map View") {
                showingMap.toggle()
            }
            .sheet(isPresented: $showingMap, content: {
                MapView()
            })
        }
        .padding()
    }
    
    func getDirectory() {
        print(URL.documentsDirectory)
    }
    
}

#Preview {
    ContentView()
}
