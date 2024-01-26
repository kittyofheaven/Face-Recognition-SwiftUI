//
//  FrameView.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 26/01/24.
//

import SwiftUI

struct FrameView: View {
    var image: CGImage?
    private let label = Text("frame")
    
    var body: some View {
        if let image = image {
            Image(image, scale: 1.0, orientation: .up, label: label)
        } else {
            Color.blue
            Text("Gabisa cuk")
        }
    }
}

#Preview {
    FrameView()
}
