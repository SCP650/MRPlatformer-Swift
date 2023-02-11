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
    
    private var gameState:GameState
    
    public init(_ gameState: GameState) {
        self.gameState = gameState
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.environment.sceneUnderstanding.options = []
        
        // Turn on occlusion from the scene reconstruction's mesh.
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        
        // Turn on physics for the scene reconstruction's mesh.
        arView.environment.sceneUnderstanding.options.insert(.physics)
        
        // Display a debug visualization of the mesh.
        arView.debugOptions.insert(.showSceneUnderstanding)
        arView.debugOptions.insert(.showWorldOrigin)
        arView.debugOptions.insert(.showPhysics)
        
        // For performance, disable render options that are not required for this app.
        arView.renderOptions = [.disablePersonOcclusion, .disableDepthOfField, .disableMotionBlur]
        
        // Manually configure what kind of AR session to run since
        // ARView on its own does not turn on mesh classification.
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
        createPlayer(view:arView)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func createPlayer(view : ARView){
        // create model
        let entity = Entity()
        let boxResource = MeshResource.generateBox(size: 0.08)
        let myMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
        let modelEntity = ModelEntity(mesh: boxResource, materials: [myMaterial])
        entity.addChild(modelEntity)
        // add game state compoenent
       
//        entity.components[CharacterControllerComponent.self] = CharacterControllerComponent(
//            radius: 0.1,
//            height: 0.1
//        )
        entity.components[GameStateComponent.self] = GameStateComponent(gameState: self.gameState)
        print("created entity in ARView")
        
        let anchor = AnchorEntity(
            plane: .horizontal,
            classification: .any
        )
        anchor.addChild(entity)
        
        view.scene.addAnchor(anchor)
        print("added to ARView")
        
    }
    
    
}

