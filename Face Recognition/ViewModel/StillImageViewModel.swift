//
//  StillImageViewModel.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 26/01/24.
//

import SwiftUI
import Vision

class StillImageViewModel: ObservableObject {
    @Published var theImage:UIImage = UIImage(named: "WomanFace") ?? UIImage()
    
    
}
