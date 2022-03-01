//
//  ediblyApp.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI
import AppTrackingTransparency

@main
struct ediblyApp: App {
    // Main Calculator object used to run Edibly
    @StateObject var vm = EdiblyViewModel()

    // Variable for Twenty One Modal
    @State var visitedTwentyOneModal = false
    
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.
      })
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                EdiblyView()
                    .environmentObject(vm)
                    .zIndex(1)
                
                if visitedTwentyOneModal != true {
                    TwentyOneModelView(visited: $visitedTwentyOneModal)
                        .transition(AnyTransition.slide)
                        .zIndex(2)
                } else {
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    requestIDFA()
                    UIApplication.shared.addTapGestureRecognizer()
                    
                }
            }
           
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
