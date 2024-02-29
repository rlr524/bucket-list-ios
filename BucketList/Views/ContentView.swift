//
//  ContentView.swift
//  BucketList
//
//  Created by Rob Ranf on 1/26/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var vm = ViewModel()
    @AppStorage("mapStyle") private var mapStyle = "standard"
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35, longitude: 139),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )
    
    var body: some View {
        if vm.isUnlocked {
            VStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(vm.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        vm.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle == "standard" ? .standard : .hybrid)
                    // Be careful not to overuse tap gestures as they are problematic with screen
                    // readers. Instead, use buttons or other built-in controls. In this case,
                    // a tap gesture must be used as that's the only way to accommodate a
                    // user tapping on the map.
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            vm.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $vm.selectedPlace) { place in
                        Text(place.name)
                        
                        EditView(location: place) {
                            vm.updateLocation(location: $0)
                        }
                    }
                }
                Picker("Map Style", selection: $mapStyle) {
                    Text("Standard")
                        .tag("standard")
                    
                    Text("Hybrid")
                        .tag("hybrid")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        } else {
            Button("Unlock Places", action: vm.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication error", isPresented: $vm.isShowingAuthenticationError) {
                    Button("OK") { }
                } message: {
                    Text(vm.authenticationError)
                }
        }
    }
}

#Preview {
    ContentView()
}
