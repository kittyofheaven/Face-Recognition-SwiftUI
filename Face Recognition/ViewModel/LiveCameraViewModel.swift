//
//  LiveCameraViewModel.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 26/01/24.
//

import AVFoundation
import Vision
import CoreImage

class LiveCameraViewModel:NSObject, ObservableObject{
    @Published var frame:CGImage?
    var permissionGranted:Bool = false
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "session queue")
    private let context = CIContext()
    
    override init(){
        super.init()
        checkPermission()
        sessionQueue.async {
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
    }
    
    
    func checkPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                permissionGranted = true
            case .notDetermined:
                requestPermission()
            case .restricted:
                requestPermission()
            case .denied:
                requestPermission()
           default:
                permissionGranted = false
        }
    }
    
    func requestPermission(){
        AVCaptureDevice.requestAccess(for: .video) { (success) in
            if success{
                self.permissionGranted = true
            } else {
                self.permissionGranted = false
            }
        }
    }
    
    func setupCaptureSession(){
        let videoOutput = AVCaptureVideoDataOutput()
        guard permissionGranted else {
            print("Permission not granted")
            return
        }
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("No Camera")
            return
        }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {return}
        guard captureSession.canAddInput(videoDeviceInput) else {return}
        captureSession.addInput(videoDeviceInput)

        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))

        captureSession.addOutput(videoOutput)

    }
    
}

extension LiveCameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }

        // All UI updates should be/must be performed on the main queue.
        DispatchQueue.main.async { [unowned self] in
            self.frame = cgImage
        }
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return cgImage
    }
    
}
