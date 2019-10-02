//
//  ContentView.swift
//  https://apphud.com
//
//  Created by Apphud on 21/06/2019.
//  Copyright © 2019 apphud. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import StoreKit

struct ContentView : View {

    @ObservedObject var productsStore : ProductsStore
    @State var show_modal = false
    
    var body: some View {
          
        VStack() {
            ForEach (productsStore.products, id: \.self) { prod in
                Text(prod.subscriptionStatus()).lineLimit(nil).frame(height: 80)
            }
            Button(action: {
                print("Button Pushed")
                self.show_modal = true
            }) {
                Text("Present")
            }.sheet(isPresented: self.$show_modal) {
                 PurchaseView()
            }
        }
    }
}
