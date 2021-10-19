//
//  EdiblyView.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI
import GoogleMobileAds
import AdSupport

struct EdiblyView: View {
    
    // Edible calculator object for running program
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    // Store Manager object for making in app purchases
    @StateObject var storeManager: StoreManager

    @State var activeSheet: ActiveSheet?
    @State var visitedTwentyOneModal = false
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case twentyOneModal, decarbView
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        
        ZStack {
            Color(.systemGray6)
            GeometryReader { geo in
            TabView {
               // First Screen
               // ------------
                VStack {
                    // Menu at the Top
                    HStack {
                        Image("edibly-logo").resizable().frame(width: 125, height: 75, alignment: .center)
                    }
                    // Spacer to Keep inputs in the middle of screen
                    Spacer()
                    // Main Inputs
                    InputsView(storeManager: StoreManager())
                    // Google Admob
                    if (storeManager.purchasedRemoveAds == false) {
                        VStack {
                            Banner()
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "house").frame(width: 15, height: 15, alignment: .center)
                    Text("Home")
                }

            // Second Screen
            // // // // // //
            InAppStorePurchasesView(storeManager: storeManager).frame(width: geo.size.width * 0.82, height:geo.size.height)
            .tabItem {
                Image(systemName: "lock").frame(width: 15, height: 15, alignment: .center)
                Text("Remove Ads")
            }
        }
        }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .twentyOneModal:
                TwentyOneModelView()
            case .decarbView:
                DecarbExplanationQuestionMarkView()
            }
        }.onAppear(perform: {
            if visitedTwentyOneModal == false {
                visitedTwentyOneModal = true
                activeSheet = .twentyOneModal
            }
            
        })
    }
    
}



struct EdiblyView_Previews: PreviewProvider {
    static var previews: some View {
        EdiblyView(storeManager: StoreManager()).environmentObject(EdiblyCalc())
    }
}


extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
