//
//  ErrorContainerView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct ErrorContainerView: View {
    
    let error: String
    let retryTrigger: (()->())?
    
    var body: some View {
        VStack{
            Text(error)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            if let retryTrigger = retryTrigger{
                Button(action: retryTrigger){
                    Text("Try again")
                        .font(.system(.subheadline))
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.regular)
                .tint(.red)
            }
        }
    }
}

#Preview {
    ErrorContainerView(error: "error", retryTrigger: nil)
}
