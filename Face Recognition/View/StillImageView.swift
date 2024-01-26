//
//  StillImageView.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 26/01/24.
//

import SwiftUI

struct StillImageView: View {
    @StateObject var viewModel:StillImageViewModel = StillImageViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Text("Input Image :")
                Spacer()
            }
            
            Image(uiImage: viewModel.theImage)
                .resizable()
                .scaledToFit()
                .padding(.bottom)
        
            HStack{
                Text("Output Image :")
                Spacer()
            }
            Image(uiImage: viewModel.theImage)
                .resizable()
                .scaledToFit()
        }
        .padding()
        
    }
}

#Preview {
    StillImageView()
}
