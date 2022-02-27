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

    @EnvironmentObject var vm: EdiblyViewModel
    @State var sliderValue = 70.0
    
    @State var activeSheet: ActiveSheet?
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case decarbView, resultsView
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        
        GeometryReader { geo in
        TabView {
           // First Screen
           // ------------
            VStack(alignment: .leading) {
                Text("Calculator")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top)
                InputForm
                // Google Admob
                Banner()
                    .environmentObject(vm)
            }
            .tabItem {
                Image(systemName: "house").frame(width: 15, height: 15, alignment: .center)
                Text("Edibly")
            }

        // Screen
        // // // // // //
            VStack(alignment: .leading) {
                Text("Recipes")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.top)
                Divider()
                List {

                    HStack() {
                        Text("Cultivar")
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption)
                            .frame(width: geo.size.width / 6)
                        Text("THC")
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption)
                            .frame(width: geo.size.width / 6)
                        Text("CBD")
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption)
                            .frame(width: geo.size.width / 6)
                        Text("Grams")
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption)
                            .frame(width: geo.size.width / 6)
                        Text("Menu")
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondaryText)
                            .font(.caption)
                            .frame(width: geo.size.width / 6)
                    }
                    
                    
                    
                    ForEach(vm.allRecipes, id: \.self) { recipe in
     
                        HStack() {
                            Text(recipe.strainName)
                                .frame(width: geo.size.width / 6)
                            Text(recipe.thc)
                                .frame(width: geo.size.width / 6)
                            Text(recipe.cbd)
                                .frame(width: geo.size.width / 6)
                            Text(recipe.weight)
                                .frame(width: geo.size.width / 6)
                            LibraryMenuView(recipe: recipe)
                                .environmentObject(vm)
                                .frame(width: geo.size.width / 6)
                                
                        }
                        .padding(.vertical, 7)
                        
                        
                    }
                }
            }
            
            
            .tabItem {
                Image(systemName: "lock").frame(width: 15, height: 15, alignment: .center)
                Text("Recipes")
            }
            
            
        // Screen
        // // // // // //
            InAppStorePurchasesView()
                .environmentObject(vm)
                .frame(width: geo.size.width * 0.82, height:geo.size.height)
                .tabItem {
                    Image(systemName: "lock").frame(width: 15, height: 15, alignment: .center)
                    Text("Remove Ads")
                }
    
        }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .resultsView:
                ResultsView()
                    .environmentObject(vm)
            case .decarbView:
                DecarbExplanationQuestionMarkView()
            }
        }
            
    }
    
}



extension EdiblyView {
    var InputForm: some View {
        Form {
            Section(header: Text("Inputs")) {
                VStack(alignment: .center) {
                    TextField("Cultivar Name", text: $vm.ediblyCalc.strainName)
                        .multilineTextAlignment(.center)
                   
                }
                .padding(.vertical, 5)
                HStack(alignment: .center) {
                    Text("Grams of cannabis")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("Grams", text: $vm.ediblyCalc.weight)
                        .multilineTextAlignment(.trailing)
                   
                }
                .padding(.vertical, 5)
                HStack(alignment: .center) {
                    Text("THC percentage")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("THC %", text: $vm.ediblyCalc.thc)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 5)
                HStack(alignment: .center) {
                    Text("CBD percentage")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("CBD %", text: $vm.ediblyCalc.cbd)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 5)
                
                TextField("Recipe Notes", text: $vm.ediblyCalc.recipeNotes)
                    .multilineTextAlignment(.center)
            }

            
            Section(header: Text("Base")) {
                HStack(alignment: .center) {
                    Text("Cups of oil, etc")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("Cups", text: $vm.ediblyCalc.cupsOfBase)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 5)
            }
            
            Section(header: Text("Number of Servings")) {
                HStack(alignment: .center) {
                    Text("Servings in dish?")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("Units", text: $vm.ediblyCalc.unitsInBatch)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 5)
            }
            
            Section(header: Text("Conversion Factor: " + String(format: "%.0f", sliderValue))) {
                VStack(alignment: .center) {
                    Slider(value: $sliderValue, in: 0...100)
                        .accentColor(Color.theme.darkGreen)
                        
                    HStack() {
                        Text("Set Conversion Factor")
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button(action: {
                            activeSheet = .decarbView
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.theme.lightGreen)
                        }
                        
                    }
                }
                .padding(.vertical, 5)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    activeSheet = .resultsView
                }) {
                    Text("Do the Thing")
                        .foregroundColor(Color.theme.darkGreen)
                        .fontWeight(.heavy)
                }
                Spacer()
            }
            
        }
    }
}

struct EdiblyView_Previews: PreviewProvider {
    static var previews: some View {
        EdiblyView()
    }
}

