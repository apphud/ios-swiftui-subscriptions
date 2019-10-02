//
//  PurchaseButton.swift
//  https://apphud.com
//
//  Created by Apphud on 21/06/2019.
//  Copyright © 2019 apphud. All rights reserved.
//

import Foundation
import SwiftUI
import StoreKit

struct PurchaseButton : View {
    
    var block : SuccessBlock!
    var product : SKProduct!
    
    var body: some View {
        
        Button(action: { 
            self.block()
        }) {
            Text(product.localizedPrice()).lineLimit(nil).multilineTextAlignment(.center).font(.subheadline)
            }.padding().frame(height: 50).scaledToFill().border(Color.blue, width: 1)
    }
}
