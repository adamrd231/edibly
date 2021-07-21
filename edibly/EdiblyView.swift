//
//  EdiblyView.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

struct EdiblyView: View {
    
    @State var interstitial: GADInterstitialAd?
    
    var testInterstitialAd = "ca-app-pub-3940256099942544/1033173712"
    var realInterstitialAd = "ca-app-pub-4186253562269967/3751660097"
    
    
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.

            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: realInterstitialAd,
                request: request, completionHandler: { [self] ad, error in
                    // Check if there is an error
                    if let error = error {
                        return
                    }
                    // If no errors, create an ad and serve it
                    interstitial = ad
                    let root = UIApplication.shared.windows.first?.rootViewController
                    interstitial!.present(fromRootViewController: root!)
                        // Let user use the app until the next time ad free
                    }
                )
        
      })
    }
    
    // Interstitial Ads
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
       print("Ad did fail to present full screen content.")
     }

     func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did present full screen content.")
     }

     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did dismiss full screen content.")
     }
    
    // Edible calculator object for running program
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    // Store Manager object for making in app purchases
    @StateObject var storeManager: StoreManager
    
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case first, second
        
        var id: Int {
            hashValue
        }
    }
    
    @State var activeSheet: ActiveSheet?
    
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            Color(.systemGray6)
            
        GeometryReader { geo in
            
            TabView {
                VStack(alignment: .center) {
                    HStack {
                        Button(action: {
                            activeSheet = .second
                        }) {
                            Text("?").font(.system(.largeTitle)).bold().foregroundColor(Color("MainColor"))
                                .padding(.top)
                        }
                    }
 
                    HStack {
                        VStack {
                            Text("THC")
                            thcTextField()
                        }
                        VStack {
                            Text("CBD")
                            cbdTextField()
                        }
                    }
                    
                    weightTextField()
                    unitsTextField()
                    
                    VStack {
                        
                        Slider(value: $ediblyCalc.conversionFactor, in: 0...100, step: 1
                        
                        ).accentColor(Color("DarkMainColor"))
                        
                        Text("Conversion Factor: \(ediblyCalc.conversionFactor.clean)")
                    }
                    
                    HStack {
                        Button(action: {
                            ediblyCalc.Calculate()
                            if (!storeManager.purchasedRemoveAds) {
                                requestIDFA()
                            }
                            
                        }) {
                            CalculateButton()
                            
                        }
                        
                    }.padding()
                    
                    VStack {
                        HStack {
                            VStack {
                                Text("THC in Batch:")
                                Text("\(ediblyCalc.THCinBatch)mg").bold()
                            }
                            
                            VStack {
                                Text("CBD in Batch:")
                                Text("\(ediblyCalc.CBDinBatch)mg").bold()
                            }
                        }
                        
                        VStack {
                            Text("Total Cannabinoids per serving")
                            HStack {
                                Text("\(ediblyCalc.THCinServing)mg THC").bold()
                                Text("\(ediblyCalc.CBDinServing)mg CBD").bold()
                            }
                        }
                    }
                    
                    if (!storeManager.purchasedRemoveAds) {
                        VStack {
                            Banner()
                        }
                    }
                    
                    
                }
                
                .frame(width: geo.size.width * 0.66, height: geo.size.height * 0.85)
                .onAppear(perform: {
                    if ediblyCalc.showedTwentyOneModal == false {
                        activeSheet = .first
                        ediblyCalc.showedTwentyOneModal = true
                    }
                })
                .tabItem {
                    Image(systemName: "house").frame(width: 15, height: 15, alignment: .center)
                    Text("Home")
                }
                
                
            
            // Second Screen
            // // // // // //
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Thank you!").bold().font(.system(size:35.0))
                    Text("Edibly is a utility calculator designed to help you get a more accurate idea of what your homemade creations will do. I like to push updates here and there and would love any ideas or feedback at adam@rdconcepts.design.").padding(.bottom)
                    Text("You've made it here, and I thank you. As a independent developer, I have always enjoyed solving unique problems with my own unique approach. In order for me to do so, I advertise on these free apps to help make money. I get it, advertising is lame and you do not really want to see a video every time you open up. Here's the deal, help me to build my future as a developer and I'll turn them off for you, forever. Just $5.")
                }
                
                HStack {
                    Button( action: {
                        storeManager.purchaseProduct(product: storeManager.myProducts.first!)
                    }) {
                        VStack {
                            if storeManager.purchasedRemoveAds == true {
                                Text("Purchased")
                            } else {
                                Text(storeManager.myProducts.first?.localizedTitle ?? "Not Available").bold()
                                    .padding()
                                    .font(.system(size:15.0))
                                    .background(Color("DarkMainColor"))
                                    .foregroundColor(.white)
                                    .cornerRadius(55.0)
                            }
                        }
                    }.padding().disabled(storeManager.purchasedRemoveAds)
                    
                    
                    Button( action: {
                        storeManager.restoreProducts()
                    }) {
                        Text("Restore Purchases").bold()
                            .padding()
                            .font(.system(size:15.0))
                            .background(Color("MainColor"))
                            .foregroundColor(.white)
                            .cornerRadius(55.0)
                    }.padding(.top).padding(.bottom).padding(.trailing)
                }
            }.frame(width: geo.size.width * 0.82, height:geo.size.height)
            
            
            .tabItem {
                Image(systemName: "lock").frame(width: 15, height: 15, alignment: .center)
                Text("Remove Ads")
            }
            
            
        }
            }
    }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .first:
                ContentView()
            case .second:
                ExplanationSheet()
            }
        }
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
