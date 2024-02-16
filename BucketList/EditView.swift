//
//  EditView.swift
//  BucketList
//
//  Created by Rob Ranf on 2/15/24.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    // Passing in a placeholder closure here because we don't need to call onSave in the preview.
    EditView(location: .example) { _ in }
}
