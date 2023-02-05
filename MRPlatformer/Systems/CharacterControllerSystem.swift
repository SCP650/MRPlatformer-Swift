//
//  CharacterControllerSystem.swift
//  MRPlatformer
//
//  Created by Atlas on 2/4/23.
//

import Foundation
import RealityKit

class CharacterControllerSystem : System {
    
    let entity: Entity
    
    required init(scene: Scene) {
        print("Init CharacterControllerSystem")
        entity = Entity()
        
        let anchor = AnchorEntity(
            plane: .horizontal,
            classification: .any
        )
        anchor.addChild(entity)
        
        let boxResource = MeshResource.generateBox(size: 0.08)
        let myMaterial = SimpleMaterial(color: .blue, roughness: 0, isMetallic: true)
        let myEntity = ModelEntity(mesh: boxResource, materials: [myMaterial])
        entity.addChild(myEntity)
        
        scene.addAnchor(anchor)
    }

    func update(context: SceneUpdateContext) {
        // RealityKit automatically calls this every frame for every scene.
    }
}
