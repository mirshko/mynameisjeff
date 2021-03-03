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
            Text(text).bold()
            
            Spacer()
        }
        .font(.headline)
        .padding(24)
        .foregroundColor(.primary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 1)
        )
        
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink(destination: SubscriptionsView()) {
                        Section(text: "Subscriptions 💸")
                    }
                    
//                    Section(text: "Moods 🌞")
                    
                    Link(destination: URL(string: "https://twitter.com/mirshko")!) {
                        Section(text: "Twitter 🕊")
                    }
                }.padding()
            }
            .navigationBarTitle("Internal")
        }
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
