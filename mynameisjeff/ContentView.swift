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
            Text("Jeff").font(.largeTitle).bold().padding()
            
            Button(action: {
                let generator = UINotificationFeedbackGenerator()
                
                generator.notificationOccurred(.success)
                
                self.showDetails.toggle()
            }) {
                Image("SwagOnMax")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180.0, height: 180.0)
                    .clipShape(RoundedRectangle(cornerRadius: (10/57 * 180.0), style: .continuous))
            }
            
            Text("@mirshko")
                .font(.title3)
                .padding()
                .scaleEffect(showDetails ? 1 : 0.92)
                .opacity(showDetails ? 1 : 0)
                .animation(.easeIn(duration: 0.150))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
