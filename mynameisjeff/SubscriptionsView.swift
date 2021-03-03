//
//  SubscriptionsView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 3/3/21.
//

import SwiftUI

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
    @State private var showingDetail = false
    
    var body: some View {
        Button(action: {
                showingDetail.toggle()
        }, label: {
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
        })
        .sheet(isPresented: $showingDetail) {
            SubscriptionDetails()
        }
        
    }
}

struct SubscriptionsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Button(action: {
                        presentationMode.wrappedValue.dismiss()
                }) {
                    Text("⬅️ Back").foregroundColor(.primary)
                }
                
                HStack {
                    Text("Subscriptions").fontWeight(.bold)
                    
                    Spacer()
                }
                
                ForEach((1...5), id: \.self) { _ in
                    Subscription()
                }
                
                Spacer()

            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}


struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView().preferredColorScheme(.dark)
    }
}
