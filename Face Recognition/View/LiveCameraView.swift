//
//  LiveCameraView.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 26/01/24.
//

import SwiftUI

struct LiveCameraView: View {
    
    @StateObject private var viewModel = LiveCameraViewModel()
    
    var body: some View {
        FrameView(image: viewModel.frame)
    }
}

#Preview {
    LiveCameraView()
}
