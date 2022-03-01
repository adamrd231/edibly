//
//  ResultsView.swift
//  edibly
//
//  Created by Adam Reed on 9/10/21.
////

import SwiftUI
import GoogleMobileAds

struct ResultsView: View {
    
    // Edible calculator object for running program
//    @EnvironmentObject var ediblyCalc: EdiblyCalc
    @EnvironmentObject var vm: EdiblyViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedPickerChoice = "By Servings"
    var selectedPickerChoices = ["By Servings", "By Tablespoons"]
    
    @State var stepperValue:Int = 0
    
    var body: some View {
        
        Form {
            Section(header: Text("Cultivar")) {
                
                Text(vm.ediblyCalc.strainName)
                    .fontWeight(.medium)
                Text(vm.ediblyCalc.recipeNotes)
         
                VStack(alignment: .leading) {
                    Text("Cups of Base")
                        .font(.caption)
                    Text(vm.ediblyCalc.cupsOfBase)

                }
                VStack(alignment: .leading) {
                    Text("Grams of Flower")
                        .font(.caption)
                    Text(vm.ediblyCalc.weight)

                }
            }.padding(5)
            
            
            
            Section(header: Text("Cannabinoid %")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("THC %")
                            .font(.caption)
                        Text(vm.ediblyCalc.thc)

                       
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("CBD %")
                            .font(.caption)
                        Text(vm.ediblyCalc.cbd)

                    }
                }
               
            }.padding(5)
            
            Section(header: Text("THC by tablespoon")) {
                VStack(alignment: .leading) {
                    Text("Total in Batch")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.THCinBatch.asNumberString()) mg thc in batch")
                }
                
 
                VStack(alignment: .leading) {
                    Text("Per Tablespoon")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.THCperTablespoon.asNumberString()) mg thc in each tablespoon")
                }

            }.padding(5)
            
            Section(header: Text("CBD by tablespoon")) {
                VStack(alignment: .leading) {
                    Text("Total in Batch")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.CBDinBatch.asNumberString()) mg cbd in batch")
                }
   
                VStack(alignment: .leading) {
                    Text("Per Tablespoon")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.CBDperTablespoon.asNumberString()) mg cbd in each tablespoon")
                }

            }.padding(5)
            
            
            Section(header: Text("Servings")) {
                VStack(alignment: .leading) {
                    Stepper("\(stepperValue) Servings",
                            onIncrement: {
                                stepperValue += 1
                                vm.ediblyCalc.unitsInBatch = String(stepperValue)
                            },
                            onDecrement: {
                                stepperValue -= 1
                                vm.ediblyCalc.unitsInBatch = String(stepperValue)
                            })
                        .onAppear(perform: {
                            stepperValue = Int(vm.ediblyCalc.unitsInBatch) ?? 0
                        })
                }
            }.padding(5)
           
            
            Section(header: Text("THC")) {
                VStack(alignment: .leading) {
                    Text("Total in Batch")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.THCinBatch.asNumberString()) mg thc in batch")
                }
                            
                // Only show thc per serving if applicable
 
                VStack(alignment: .leading) {
                    Text("Per Serving")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.THCinServing.asNumberString()) mg thc per serving")
                }
                
            }.padding(5)
            
            Section(header: Text("CBD")) {
                VStack(alignment: .leading) {
                    Text("Total in Batch")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.CBDinBatch.asNumberString()) mg cbd in batch")
                }

                // Only show thc per serving if applicable
                VStack(alignment: .leading) {
                    Text("Per Serving")
                        .font(.caption)
                    Text("\(vm.ediblyCalc.CBDinServing.asNumberString()) mg cbd per serving")
                }
            
            }.padding(5)

            
            
            Section {
                Button(action: {
                    vm.recipeDataService.addRecipe(recipeEntered: vm.ediblyCalc)
                    
                }) {
                    if vm.allRecipes.contains(where: { $0.strainName == vm.ediblyCalc.strainName}) {
                        Text("Recipe Already Saved")
                            .foregroundColor(Color.theme.secondaryText)
                            .fontWeight(.bold)
                            .opacity(0.66)
                    } else {
                        Text("Save to Recipes")
                            .foregroundColor(Color.theme.lightGreen)
                            .fontWeight(.bold)
                    }
                    
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                        .foregroundColor(Color.theme.lightGreen)
                        .fontWeight(.bold)
                }
                
            }.padding(5)
            
        }
        .background(Color.theme.background)
        Banner()
            .environmentObject(vm)
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}


// Google admob interstitial video stuff
//@State var interstitial: GADInterstitialAd?
//var testInterstitialAd = "ca-app-pub-3940256099942544/1033173712"
//var realInterstitialAd = "ca-app-pub-4186253562269967/3751660097"
//func playInterstitial() {
//    let request = GADRequest()
//    GADInterstitialAd.load(
//        withAdUnitID: testInterstitialAd,
//        request: request,
//        completionHandler: { [self] ad, error in
//            // Check if there is an error
//            if let error = error {
//                print("There was an error: \(error)")
//                return
//            }
//            // If no errors, create an ad and serve it
//            interstitial = ad
//
//            if let interstitalAd = interstitial {
//                let root = UIApplication.shared.windows.last?.rootViewController
//                interstitalAd.present(fromRootViewController: root!)
//            }
//
//            }
//        )
//}
