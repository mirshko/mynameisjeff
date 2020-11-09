//
//  ContentView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 8/15/20.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            Link(destination: URL(string: "https://twitter.com/mirshko")!, label: {
                Text("JEFF").font(.largeTitle).bold().foregroundColor(.primary)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
