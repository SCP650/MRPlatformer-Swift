//
//  CharacterControllerSystem.swift
//  MRPlatformer
//
//  Created by Atlas on 2/4/23.
//

import Foundation
import RealityKit

class PlayerControllerSystem : System {
    
    private static let query = EntityQuery(where: .has(GameStateComponent.self))
    
    var playerEntity : Entity?
    
    required init(scene: Scene) { print("ini character system called") }

    func update(context: SceneUpdateContext) {
        if(playerEntity == nil){
            playerEntity = context.scene.performQuery(Self.query).map({ $0 }).first
        }
        
        guard let gameState = (playerEntity?.components[GameStateComponent.self] as? GameStateComponent)?.gameState else {return }
        var JumpSpeed = Float(0)
        if(gameState.shouldJump){
            JumpSpeed = Float(5)
            gameState.shouldJump = false
        }
        let forces = SIMD3<Float>(
            gameState.characterSpeed.x,
            JumpSpeed,
            gameState.characterSpeed.y
        )
        let deltaTime = Float(context.deltaTime)
        playerEntity?.moveCharacter(
            by: forces * deltaTime,
            deltaTime: deltaTime,
            relativeTo: nil
        )
        //print("the speed now is \(gameState.characterSpeed.x), \(gameState.characterSpeed.y)")
    }
    
 
}
