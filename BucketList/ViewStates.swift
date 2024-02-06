//
//  ViewStates.swift
//  BucketList
//
//  Created by Rob Ranf on 1/30/24.
//

import SwiftUI

struct ViewStates: View {
    @State private var loadingState = LoadingState.success
    
    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
    
    enum LoadingState {
        case loading, success, failed
    }
    
    struct LoadingView: View {
        var body: some View {
            Text("Loading...")
        }
    }
    
    struct SuccessView: View {
        var body: some View {
            Text("Success!")
        }
    }
    
    struct FailedView: View {
        var body: some View {
            Text("Failed")
        }
    }
}

#Preview {
    ViewStates()
}
