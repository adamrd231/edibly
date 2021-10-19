//
//  ResultsView.swift
//  edibly
//
//  Created by Adam Reed on 9/10/21.
//

import SwiftUI
import GoogleMobileAds

struct ResultsView: View {
    
    // Edible calculator object for running program
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    @Environment(\.presentationMode) var presentationMode
    
    // Store Manager object for making in app purchases
    @StateObject var storeManager: StoreManager
    
    // Google admob interstitial video stuff
    @State var interstitial: GADInterstitialAd?
    var testInterstitialAd = "ca-app-pub-3940256099942544/1033173712"
    var realInterstitialAd = "ca-app-pub-4186253562269967/3751660097"
    func playInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: realInterstitialAd,
            request: request, completionHandler: { [self] ad, error in
                // Check if there is an error
                if let error = error {
                    print("There was an error: \(error)")
                    return
                }
                print("No Errors No errors no errors")
                // If no errors, create an ad and serve it
                interstitial = ad
                print(interstitial)
                if let interstitalAd = interstitial {
                    print(interstitalAd)
                    let root = UIApplication.shared.windows.last?.rootViewController
                    interstitalAd.present(fromRootViewController: root!)
                }
               
                }
            )
    }
    
    var body: some View {
        
        List {
            Section(header: Text("Results")) {
                HStack() {
                    Text("Total of THC")
                    Spacer()
                    Text("\(String(format: "%.2f", ediblyCalc.THCinBatch)) mg").bold()
                }
                
                HStack {
                    Text("Total of CBD")
                    Spacer()
                    Text("\(String(format: "%.2f", ediblyCalc.CBDinBatch)) mg").bold()
                }
                
                HStack {
                    Text("THC per Teaspoon")
                    Spacer()
                    Text("\(String(format: "%.2f", ediblyCalc.THCperTeaspoon)) mg").bold()
                }
                HStack {
                    Text("CBD per Teaspoon")
                    Spacer()
                    Text("\(String(format: "%.2f", ediblyCalc.CBDperTeaspoon)) mg").bold()
                }
            }
            
            Section(header: Text("Calculate by portion")) {
                VStack(alignment: .leading) {
                    Stepper((ediblyCalc.unitsInBatch == 1) ? "\(ediblyCalc.unitsInBatch) Unit" : "\(ediblyCalc.unitsInBatch) Units", value: $ediblyCalc.unitsInBatch, in: 1...100, step: 1)
                }
                HStack {
                    Text("Estimated THC per portion")
                    Spacer()
                    Text("\(String(format: "%.2f", ediblyCalc.THCperPortion)) mg")
                }
                HStack {
                    Text("Estimated CBD per portion")
                    Spacer()
                    Text("\(String(format: "%.2f", ediblyCalc.CBDperPortion)) mg")
                }
            }
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("GOT IT? GOOD.")
                    .foregroundColor(Color(.white)).bold()
                    .padding()
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)
                    .background(Color("MainColor"))
                    .cornerRadius(15.0)
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            if storeManager.purchasedRemoveAds == false {
                playInterstitial()
            }
        })
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(storeManager: StoreManager()).environmentObject(EdiblyCalc())
    }
}
