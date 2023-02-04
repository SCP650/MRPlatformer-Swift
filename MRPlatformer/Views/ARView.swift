//
//  ARView.swift
//  MRPlatformer
//
//  Created by Atlas on 2/4/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.environment.sceneUnderstanding.options = []
        
        // Turn on occlusion from the scene reconstruction's mesh.
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        
        // Turn on physics for the scene reconstruction's mesh.
        arView.environment.sceneUnderstanding.options.insert(.physics)
        
        // Display a debug visualization of the mesh.
        arView.debugOptions.insert(.showSceneUnderstanding)
        
        // For performance, disable render options that are not required for this app.
        arView.renderOptions = [.disablePersonOcclusion, .disableDepthOfField, .disableMotionBlur]
        
        // Manually configure what kind of AR session to run since
        // ARView on its own does not turn on mesh classification.
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
