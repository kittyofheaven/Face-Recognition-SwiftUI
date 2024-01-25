//
//  DetectFaces.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 25/01/24.
//

import SwiftUI
import Vision

class StillFacesViewModel:ObservableObject {
    
    var image: UIImage = UIImage()
    @Published var outputImage: UIImage?
    @Published var detectedFaces: [VNFaceObservation] = [VNFaceObservation()]
    
    func detectFaces(in image: UIImage){
        guard let ciImage = image.ciImage else {
            print("Unable to convert image to ciImage")
            return
        }
        
        let request = VNDetectFaceRectanglesRequest(completionHandler: self.handleFaceData)
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            try handler.perform([request])
        } catch let requestError{
            print("Unable to perform request: \(requestError.localizedDescription)")
        }
        
    }
    
    func handleFaceData(request: VNRequest, error: Error?){
        DispatchQueue.main.async {
            guard let results = request.results as? [VNFaceObservation] else{
               return
            }
            self.detectedFaces = results
            
            for face in self.detectedFaces {
                self.addRectangle(result: face)
            }
            
            self.outputImage = self.image
            
        }
    }
    
    func addRectangle(result: VNFaceObservation){
        let imageSize = CGSize(width: image.size.width, height: image.size.height)
        let boundingBox = result.boundingBox
        let scaledBox = CGRect(
            x: boundingBox.origin.x * imageSize.width,
            y: (1-boundingBox.origin.y - boundingBox.size.height) * imageSize.height,
            width: boundingBox.size.width * imageSize.width,
            height: boundingBox.size.height * imageSize.height
        )
        let normalizedRect = VNNormalizedRectForImageRect(scaledBox,Int(imageSize.width), Int(imageSize.height))
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(100.0)
        
        let rect = CGRect(
            x: normalizedRect.origin.x * imageSize.width,
            y: normalizedRect.origin.y * imageSize.height,
            width: normalizedRect.size.width * imageSize.width,
            height: normalizedRect.size.height * imageSize.height
        )
        context.stroke(rect)
        
    }
    
}
