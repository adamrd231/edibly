//
//  ediblyApp.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

@main
struct ediblyApp: App {
    
    @StateObject var ediblyCalc = EdiblyCalc()
    
    var body: some Scene {
        WindowGroup {
            EdiblyView().environmentObject(ediblyCalc)
        }
    }
}
