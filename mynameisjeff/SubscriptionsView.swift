//
//  SubscriptionsView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 3/3/21.
//

import SwiftUI
import BottomSheet

struct SubscriptionDetails: View {
    var body: some View {
        Capsule()
            .fill(Color(.tertiaryLabel))
            .frame(width: 36, height: 5)
            .padding(5)
        
        VStack(alignment: .leading) {
            
            Text("🏡 Rent").font(.headline).bold()
            
            Spacer()
            
            
            Spacer()
        }.padding()
    }
}

struct Subscription: View {
    
    
    var body: some View {
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
        }.padding(16)
        .foregroundColor(.primary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

struct SubscriptionsView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var bottomSheetPosition: BottomSheetPosition = .hidden
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("⬅️ Back").foregroundColor(.primary)
//                }
                
//                HStack {
//                    Text("Subscriptions").font(.largeTitle).fontWeight(.bold)
//
//                    Spacer()
//                }
                
                ForEach((1...5), id: \.self) { _ in
                    Button(action: {
                        withAnimation(.linear) {
                            self.bottomSheetPosition = .middle
                        }
                    }, label: {
                        Subscription()
                    })
                }
                
                Spacer()
                
            }
            .padding()
            
        }
        .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, showCancelButton: true, content: {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("🏡").font(.system(size: 80))
                        
                        Text("Rent").font(.largeTitle).bold()
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Divider()
                }.padding(.vertical, 16)
                
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Cost").font(.title3).foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("€467.32")
                    }
                    
                    HStack {
                        Text("Billing Method").font(.title3).foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("Direct Debit")
                            .bold()
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color("N26").opacity(0.5))
                            .cornerRadius(4)
                    }
                    
                    HStack {
                        Text("Cycle").font(.title3).foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("Monthly")
                            .bold()
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.systemGray5))
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.top, -56)
        }, closeAction: {
            self.bottomSheetPosition = .hidden
        })
        .navigationBarTitle("Subscriptions")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView().preferredColorScheme(.dark)
    }
}
