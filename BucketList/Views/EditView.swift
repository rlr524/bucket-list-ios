//
//  EditView.swift
//  BucketList
//
//  Created by Rob Ranf on 2/15/24.
//

import SwiftUI

struct EditView: View {
    @State private var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    var onSave: (PinnedLocation) -> Void
    

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $vm.name)
                    TextField("Description", text: $vm.description)
                }
                
                Section("Nearby...") {
                    switch vm.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(vm.wikipediaPages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later...")
                    }
                    
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = vm.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await vm.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: PinnedLocation, onSave: @escaping (PinnedLocation) -> Void) {
        self.onSave = onSave
        _vm = State(initialValue: ViewModel(location: location))
    }
}

#Preview {
    // Passing in a placeholder closure here because we don't need to call onSave in the preview.
    EditView(location: .example) { _ in }
}
