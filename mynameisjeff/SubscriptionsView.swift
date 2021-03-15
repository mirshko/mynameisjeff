//
//  SubscriptionsView.swift
//  mynameisjeff
//
//  Created by Jeffrey Reiner on 3/3/21.
//

import SwiftUI

struct SubscriptionDetailsModalView: View {
    var body: some View {
        Capsule()
            .fill(Color(.tertiaryLabel))
            .frame(width: 36, height: 5)
            .padding(5)
        
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("🏡").font(.system(size: 80))
                    
                    Text("Rent").font(.largeTitle).bold()
                }
                
                Spacer()
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Cost").foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("€467.32")
                }
                
                HStack {
                    Text("Billing Method").foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("Direct Debit")
                        .font(.callout)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color("N26").opacity(0.5))
                        .cornerRadius(4)
                }
                
                HStack {
                    Text("Cycle").foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("Monthly")
                        .font(.callout)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color(.systemGray5))
                        .cornerRadius(4)
                }
                
                HStack {
                    Text("Tags").foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Text("Essentials")
                            .font(.callout)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(.systemBlue).opacity(0.2))
                            .cornerRadius(4)
                        
                        Text("Business")
                            .font(.callout)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(.systemYellow).opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct Subscription: View {
    @State private var showModal = false
    
    var body: some View {
        Button(
            action: {
                self.showModal = true
            },
            label: {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("🏡 Rent").font(.title3).bold()
                        
                        Text("€467.32").font(.body)
                        
                        HStack(spacing: 8) {
                            Text("Monthly")
                                .font(.callout)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(.systemGray5))
                                .cornerRadius(4)
                            
                            Text("Direct Debit")
                                .font(.callout)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
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
        )
        .sheet(isPresented: $showModal, onDismiss: {
            print(self.showModal)
        }) {
            SubscriptionDetailsModalView()
        }
    }
}

struct SubscriptionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach((1...10), id: \.self) { _ in
                    Subscription()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Subscriptions")
        .navigationBarTitleDisplayMode(.large)
    }
}


struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView().preferredColorScheme(.dark)
    }
}
