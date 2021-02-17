//
//  ContentView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 8/15/20.
//

import SwiftUI

struct Section: View {
    var text: String
    
    var body: some View {
        HStack() {
            Text(text)
            Spacer()
        }
        .font(.headline)
        .padding()
        .background(Color(.systemGray5))
        .foregroundColor(.primary)
        .cornerRadius(16)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemGray6).edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView() {
                    Section(text: "Jeff Reiner")
                    
                    Section(text: "I'm currently freelancing as a design engineer located in Berlin, as well as working on frontend at Union and design at Soapbox.")
                    
                    Section(text: "I focus on engaging, responsive, mobile-first websites and apps; highly-usable and efficient design systems; and solving complex UX problems, in and around the Web 2.0 and Web3 space.")
                }.cornerRadius(16).padding()
                
                HStack(alignment: .center) {
                    Link(destination: URL(string: "https://twitter.com/mirshko")!, label: {
                        Text("JEFF").font(.largeTitle).bold().foregroundColor(.primary)
                    })
                }.padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
