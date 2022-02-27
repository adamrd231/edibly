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
     
        VStack(alignment: .leading) {
            Text("Recipe")
                .font(.title3)
                .fontWeight(.medium)
        }.padding()
        
        Form {
            
            if vm.ediblyCalc.strainName != "" {
                Section(header: Text("Cultivar")) {
                    Text(vm.ediblyCalc.strainName)
                        .fontWeight(.medium)
                    if vm.ediblyCalc.recipeNotes != "" {
                        Text(vm.ediblyCalc.recipeNotes)
                    }
                    
                }
            }
            
            Section(header: Text("Cannabinoids")) {
                HStack {
                    VStack {
                        Text("THC")
                        Text(vm.ediblyCalc.thc)
                    }
                    Spacer()
                    VStack {
                        Text("CBD")
                        Text(vm.ediblyCalc.cbd)
                    }
                }
               
            }
            
            Section(header: Text("Cups of Oil, Intended Servings")) {
                HStack {
                    VStack {
                        Text("Cups of Oil")
                        Text(vm.ediblyCalc.cupsOfBase)
                    }
                    Spacer()
                    VStack {
                        Text("Servings")
                        Text(vm.ediblyCalc.unitsInBatch)
                    }
                    
                }
        
            }
            
            Section(header: Text("Update Servings")) {
                VStack(alignment: .leading) {
                    Stepper("Update Servings to \(stepperValue)", value: $stepperValue, in: 0...100)
                    Button(action: {
                        vm.ediblyCalc.unitsInBatch = String(stepperValue)
                    }) {
                        Text("Update")
                            .foregroundColor(Color.theme.darkGreen)
                            .fontWeight(.bold)
                    }
                }
                .onAppear(perform: {
                    stepperValue = Int(vm.ediblyCalc.unitsInBatch) ?? 0
                })
            }
           
            
            Section(header: Text("Options")) {
                Picker("How to split recipe", selection: $selectedPickerChoice) {
                    ForEach(selectedPickerChoices, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("THC")) {
                VStack(alignment: .leading) {
                    Text("Total in Batch")
                        .fontWeight(.medium)
                    Text("\(vm.ediblyCalc.THCinBatch.asNumberString()) mg thc in batch")
                }
                
                
                // Only show thc per tablespoon if applicable
                if selectedPickerChoice == "By Tablespoons" {
                    VStack(alignment: .leading) {
                        Text("Per Tablespoon")
                            .fontWeight(.medium)
                        Text("\(vm.ediblyCalc.THCperTablespoon.asNumberString()) mg thc in each tablespoon")
                    }
                }
                
                // Only show thc per serving if applicable
                if selectedPickerChoice == "By Servings" {
                    VStack(alignment: .leading) {
                        Text("Per Serving")
                            .fontWeight(.medium)
                        Text("\(vm.ediblyCalc.THCinServing.asNumberString()) mg thc per serving")
                    }
                }
            }

            Section(header: Text("CBD")) {
                VStack(alignment: .leading) {
                    Text("Total in Batch")
                        .fontWeight(.medium)
                    Text("\(vm.ediblyCalc.CBDinBatch.asNumberString()) mg cbd in batch")
                }
                
                
                // Only show thc per tablespoon if applicable
                if selectedPickerChoice == "By Tablespoons" {
                    VStack(alignment: .leading) {
                        Text("Per Tablespoon")
                            .fontWeight(.medium)
                        Text("\(vm.ediblyCalc.CBDperTablespoon.asNumberString()) mg cbd in each tablespoon")
                    }
                }
                
                // Only show thc per serving if applicable
                if selectedPickerChoice == "By Servings" {
                    VStack(alignment: .leading) {
                        Text("Per Serving")
                            .fontWeight(.medium)
                        Text("\(vm.ediblyCalc.CBDinServing.asNumberString()) mg cbd per serving")
                    }
                }
            }
            
            Section {
                Button(action: {
                    vm.recipeDataService.addRecipe(recipeEntered: vm.ediblyCalc)
                    
                }) {
                    if vm.allRecipes.contains(vm.ediblyCalc) {
                        Text("Update Recipe")
                            .foregroundColor(Color.theme.darkGreen)
                            .fontWeight(.bold)
                    } else {
                        Text("Save to Recipes")
                            .foregroundColor(Color.theme.darkGreen)
                            .fontWeight(.bold)
                    }
                    
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dismiss")
                        .foregroundColor(Color.theme.darkGreen)
                        .fontWeight(.bold)
                }
                
            }
            
        }
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
