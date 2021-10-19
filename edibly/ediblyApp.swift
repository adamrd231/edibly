//
//  ediblyApp.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI
import GoogleMobileAds
import StoreKit
import AppTrackingTransparency

@main
struct ediblyApp: App {
    // Main Calculator object used to run Edibly
    @StateObject var ediblyCalc = EdiblyCalc()
    // Product Id's from App Store Connect
    var productIds = ["hideAdvertising"]
    // Store Manager object to make In App Purchases
    @StateObject var storeManager = StoreManager()
    
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.
      })
    }
    
    var body: some Scene {
        WindowGroup {
            EdiblyView(storeManager: storeManager).environmentObject(ediblyCalc)
                .onAppear(perform: {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIds)
                })
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .onAppear(perform: {
                    requestIDFA()
                })
        }
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
