//
//  GameStateComponent.swift
//  MRPlatformer
//
//  Created by Atlas on 2/11/23.
//

import Foundation
import RealityKit

struct GameStateComponent: RealityKit.Component {
    var gameState: GameState
}

class GameState:ObservableObject{
    @Published var characterSpeed: SIMD2<Float> = SIMD2(0.0, 0.0) // Length between 0 and 1.
    @Published var jumpSpeed: Float = 0
}


