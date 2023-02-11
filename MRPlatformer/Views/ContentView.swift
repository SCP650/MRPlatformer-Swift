//
//  ContentView.swift
//  MRPlatformer
//
//  Created by Atlas on 2/3/23.
//

import SwiftUI

struct ContentView : View {
    @StateObject private var gameState = GameState()
    
    var body: some View {
        ARViewContainer(gameState)
            .edgesIgnoringSafeArea(.all)
            .gesture(
                DragGesture()
                    .onChanged({ event in
                var translation = 1E-2 * SIMD2<Float>(Float(event.translation.width), Float(event.translation.height))
                gameState.characterSpeed = translation
            })
                    .onEnded({ _ in gameState.characterSpeed = SIMD2(0, 0) })
            )
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
