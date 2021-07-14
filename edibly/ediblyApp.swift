//
//  ediblyApp.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI
import GoogleMobileAds
import StoreKit

@main
struct ediblyApp: App {
    // Main Calculator object used to run Edibly
    @StateObject var ediblyCalc = EdiblyCalc()
    // Product Id's from App Store Connect
    var productIds = ["hideAdvertising"]
    // Store Manager object to make In App Purchases
    @StateObject var storeManager = StoreManager()
    
    var body: some Scene {
        WindowGroup {
            EdiblyView(storeManager: storeManager).environmentObject(ediblyCalc)
                .onAppear(perform: {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIds)
                })
        }
    }
}
