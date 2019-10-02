//
//  ContentView.swift
//  https://apphud.com
//
//  Created by Apphud on 21/06/2019.
//  Copyright © 2019 apphud. All rights reserved.
//

import Foundation
import SwiftUI
import StoreKit
import Combine

struct PurchaseView : View {
    
    @State private var isDisabled : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }

    var body: some View {
                           
        ScrollView (showsIndicators: false) {
            
            VStack {
                Text("Get Premium Membership").font(.title)
                Text("Choose one of the packages above").font(.subheadline)
                
                self.purchaseButtons()
                self.aboutText()
                self.helperButtons()
                self.termsText().frame(width: UIScreen.main.bounds.size.width)
                self.dismissButton()
                
                }.frame(width : UIScreen.main.bounds.size.width)
            }.disabled(self.isDisabled)    
    }

    // MARK:- View creations
    
    func purchaseButtons() -> some View {
        // remake to ScrollView if has more than 2 products because they won't fit on screen.
        HStack {
            Spacer()
            ForEach(ProductsStore.shared.products, id: \.self) { prod in
                PurchaseButton(block: { 
                    self.purchaseProduct(skproduct: prod)
                }, product: prod).disabled(IAPManager.shared.isActive(product: prod))
            }
            Spacer()
        }
    }
    
    func helperButtons() -> some View{
        HStack {
            Button(action: { 
                self.termsTapped()
            }) {
                Text("Terms of use").font(.footnote)
            }
            Button(action: { 
                self.restorePurchases()
            }) {
                Text("Restore purchases").font(.footnote)
            }
            Button(action: { 
                self.privacyTapped()
            }) {
                Text("Privacy policy").font(.footnote)
            }
            }.padding()
    }
    
    func aboutText() -> some View {
        Text("""
                • Unlimited searches
                • 100GB downloads
                • Multiplatform service
                """).font(.subheadline).lineLimit(nil)
    }
    
    func termsText() -> some View{
        // Set height to 600 because SwiftUI has bug that multiline text is getting cut even if linelimit is nil.
        VStack {
            Text(terms_text).font(.footnote).lineLimit(nil).padding()
            Spacer()
            }.frame(height: 350)                                        
    }
    
    func dismissButton() -> some View {
        Button(action: { 
            self.dismiss()
        }) {
            Text("Not now").font(.footnote)
            }.padding()
    }
    
    //MARK:- Actions
    
    func restorePurchases(){
        
        IAPManager.shared.restorePurchases(success: { 
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            self.dismiss()
            
        }) { (error) in
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            
        }
    }
    
    func termsTapped(){
        
    }
    
    func privacyTapped(){
        
    }
    
    func purchaseProduct(skproduct : SKProduct){
        print("did tap purchase product: \(skproduct.productIdentifier)")
        isDisabled = true
        IAPManager.shared.purchaseProduct(product: skproduct, success: { 
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
            self.dismiss()
        }) { (error) in
            self.isDisabled = false
            ProductsStore.shared.handleUpdateStore()
        }        
    }
}
