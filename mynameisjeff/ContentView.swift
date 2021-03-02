//
//  ContentView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 8/15/20.
//

import SwiftUI


struct Mood: Decodable, Hashable {
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

struct MoodSection: View {
    static let dateFormatter = DateFormatter()
    static let relativeFormatter = RelativeDateTimeFormatter()
    
    var mood: Mood
    
    
    
    var body: some View {
        
//        Self.dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
//
//        Self.relativeFormatter.unitsStyle = .full
//
//        let relativeDate = Self.relativeFormatter.localizedString(for: Self.dateFormatter.date(from: mood.timestamp)!, relativeTo: Date())
        
        return HStack() {
            VStack(alignment: .leading) {
                Text(mood.mood)
                Text("\(mood.timestamp)")
            }
            Spacer()
        }
    }
}

struct ContentView: View {
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
        ZStack {
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                ScrollView() {
                    Section(text: "Jeff Reiner")
                    
                    Section(text: "I'm currently freelancing as a design engineer located in Berlin, as well as working on frontend at Union and design at Soapbox.")
                    
                    Section(text: "I focus on engaging, responsive, mobile-first websites and apps; highly-usable and efficient design systems; and solving complex UX problems, in and around the Web 2.0 and Web3 space.")
                    
                    if (moods != nil) {
                        ForEach(moods!.datas, id: \.self) {
                            MoodSection(mood: $0)
                        }
                    }
                }.cornerRadius(16).padding()
                
                HStack(alignment: .center) {
                    Link(destination: URL(string: "https://twitter.com/mirshko")!, label: {
                        Text("MOODS").font(.largeTitle).bold().foregroundColor(.primary)
                    })
                }.padding()
            }
        }.onAppear(perform: fetch)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
