//
//  ContentView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 8/15/20.
//

import SwiftUI


struct Mood: Decodable, Hashable, Identifiable {
    let id: Int
    let timestamp: String
    let mood: String
}

struct Payload: Decodable {
    let datas: [Mood]
}

struct API {
    let baseURL = URL(string: "https://api.sheety.co/c869389178ef5915c2a748411733f36f/logMoodShortcut/datas")
    
    // create our fetch function with a responder handler callback
    func fetch (handler: @escaping (Result<Payload, Error>) -> Void) {
        
        // ensure that our url is unpacked
        guard let url = baseURL else {
            print("error...")
            return
        }
        
        // use URLSession to fetch our data
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            // handle network errors
            if let error = error {
                handler(.failure(error))
            } else {
                
                // attempt to decode our JSON
                do {
                    // attempt to decode
                    let encoder = JSONDecoder()
                    
                    // convert any snake_case to camelCase
                    encoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let data = data ?? Data()
                    
                    let moods = try encoder.decode(Payload.self, from: data)
                    
                    handler(.success(moods))
                } catch {
                    handler(.failure(error))
                }
                
            }
            
        }
        
        task.resume()
    }
}



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

struct MoodsSection: View {
    @State var loading = false
    @State var error = false
    @State var moods: Payload?
    
    func fetch () {
        loading = true
        error = false
        
        API().fetch() { result in
            self.loading = false
            
            // handle success or failure
            switch result {
            case .success(let moods):
                print("Success! \(moods)")
                self.moods = moods
                
            case .failure: self.error = true
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if (loading) {
                Text("Loading")
                    .font(.largeTitle)
                    .bold()
            }
            
            if (error) {
                Text("Error")
                    .foregroundColor(Color(.systemRed))
                    .font(.largeTitle)
                    .bold()
            }
            
            if (moods != nil) {
                ScrollView {
                    ForEach(moods!.datas) { mood in
                        HStack {
                            Text(mood.mood)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .onAppear(perform: fetch)
    }
}

struct SubscriptionsSection: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Button(action: {
                        presentationMode.wrappedValue.dismiss()
                }) {
                    Text("⬅️ Back")
                }
                
                HStack {
                    Text("Subscriptions").fontWeight(.bold)
                    
                    Spacer()
                }
                
                ForEach((1...10), id: \.self) { _ in
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("🏡 Rent").font(.headline).bold()
                            
                            Text("€467.32").font(.callout)
                            
                            HStack(spacing: 8) {
                                Text("Monthly")
                                    .font(.caption)
                                    .bold()
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(4)
                                
                                Text("Direct Debit")
                                    .font(.caption)
                                    .bold()
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color("N26").opacity(0.5))
                                    .cornerRadius(4)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                    .foregroundColor(.primary)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 1)
                    )
                }
                
                Spacer()

            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Internal").fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    NavigationLink(destination: SubscriptionsSection()) {
                        Section(text: "Subscriptions 💸")
                    }
                    
                    Section(text: "Moods 🌞")
                    
                    Section(text: "Tools 🛠")
                }.padding()
            }
            .navigationBarHidden(true)
        }
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
