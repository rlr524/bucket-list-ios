//
//  AuthenticationView.swift
//  BucketList
//
//  Created by Rob Ranf on 2/6/24.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @State var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // Check with user as to if biometric authentication is possible.
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // User states it's possible, so use biometrics.
            // The reason string for TouchID is passed here as opposed to the reason for
            // FaceID, which is passed in the info.plist file.
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    AuthenticationView()
}
