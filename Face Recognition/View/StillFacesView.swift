//
//  StillFacesView.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 26/01/24.
//

import SwiftUI

struct StillFacesView: View {
    @State private var image:UIImage = UIImage(named: "Woman") ?? UIImage()
    @ObservedObject var viewModel = StillFacesViewModel()
    
    
    var body: some View {
        if viewModel.outputImage != nil {
            Image(uiImage: viewModel.outputImage!)
                .resizable()
                .scaledToFit()
        } else {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        
        Button(action: {
            viewModel.image = image
            viewModel.detectFaces(in: image)
        }, label: {
            Text("Process Image")
        })
    }
}

#Preview {
    StillFacesView()
}
