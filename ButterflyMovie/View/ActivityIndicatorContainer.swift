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
            CustomActivityIndicator()
                .frame(maxWidth: .infinity)
        }else if let error = error{
            HStack{
                Spacer()
                ErrorContainerView(error: error, retryTrigger: retryTrigger)
                Spacer()
            }
        }
    }
}

struct CustomActivityIndicator: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .foregroundColor(.red)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .onAppear {
                if !isAnimating {
                    let animation: Animation  =
                    Animation.linear(duration: 0.1)
                        .repeatForever(autoreverses: false)
                    withAnimation(animation) {
                        isAnimating = true
                    }
                }
            }
            .onDisappear {
                isAnimating = false
            }
    }
}


#Preview {
    ActivityIndicatorContainer(isLoading: true, error: nil, retryTrigger: nil)
}

