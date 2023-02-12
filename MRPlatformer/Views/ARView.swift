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
        arView.environment.sceneUnderstanding.options.insert([.collision, .physics, .receivesLighting, .occlusion])
         
        
        // Display a debug visualization of the mesh.
        arView.debugOptions.insert(.showSceneUnderstanding)
        arView.debugOptions.insert(.showWorldOrigin)
//        arView.debugOptions.insert(.showPhysics)
        
        // For performance, disable render options that are not required for this app.
        arView.renderOptions = [.disablePersonOcclusion, .disableDepthOfField, .disableMotionBlur]
        
        // Manually configure what kind of AR session to run since
        // ARView on its own does not turn on mesh classification.
        arView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .mesh
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
        createPlayer(view:arView)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func createPlayer(view : ARView){
        let radius : Float = 0.2
        // create model
        let entity = Entity()
        let boxResource = MeshResource.generateBox(size: radius)
        let myMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: false)
        let modelEntity = ModelEntity(mesh: boxResource, materials: [myMaterial])
        entity.addChild(modelEntity)
        // add game state compoenent
        entity.position.y = radius / 2
       
        entity.components[CharacterControllerComponent.self] = CharacterControllerComponent(
            radius: radius,
            height: radius*2
        )
//        entity.components[CharacterControllerStateComponent.self] = CharacterControllerStateComponent()
//        entity.characterController = CharacterControllerComponent()
        entity.components[GameStateComponent.self] = GameStateComponent(gameState: self.gameState)
        print("created entity in ARView")
        
        let anchor = AnchorEntity(
            plane: .horizontal,
            classification: .any,
            minimumBounds: 1.0 * .init(radius, radius)
        )
        anchor.addChild(entity)
        
        view.scene.addAnchor(anchor)
        print("added to ARView")
        
    }
    
    
}

