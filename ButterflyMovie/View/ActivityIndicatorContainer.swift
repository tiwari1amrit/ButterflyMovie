//
//  ActivityIndicator.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct ActivityIndicatorContainer: View {
    let isLoading: Bool
    let error: String?
    let retryTrigger: (()->())?
    
    var body: some View {
            if isLoading{
                HStack() {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        .scaleEffect(2.5)
                    Spacer()
                }
            }else if error != nil {//else if let error = error{
                HStack{
                    Spacer()
                    ErrorContainerView(error: error!, retryTrigger: retryTrigger)
                    Spacer()
                }
            }
    }
}


#Preview {
    ActivityIndicatorContainer(isLoading: true, error: nil, retryTrigger: nil)
}
