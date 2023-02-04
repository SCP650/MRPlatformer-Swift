//
//  ContentView.swift
//  MRPlatformer
//
//  Created by Atlas on 2/3/23.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
