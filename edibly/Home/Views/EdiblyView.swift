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
    
    var gradient = LinearGradient(gradient: Gradient(colors: [Color.theme.darkGreen, Color.theme.blackColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
    var gradientlayer = CAGradientLayer()
    
    @State var activeSheet: ActiveSheet?
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case decarbView, resultsView
        
        var id: Int {
            hashValue
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        
    }
    
    @State var InterstitialAdCounter = 0 {
        didSet {
            print("Interstitial ad count \(InterstitialAdCounter)")
            if InterstitialAdCounter >= 5 {
                if vm.removedAdvertising != true {
                    loadInterstitialAd()
                    InterstitialAdCounter = 0
                }
            }
        }
    }
    
    @State var interstitial: GADInterstitialAd?


        // Test Ad
//        var googleBannerInterstitialAdID = "ca-app-pub-3940256099942544/1033173712"

        // Real Ad
        var googleBannerInterstitialAdID = "ca-app-pub-4186253562269967/5364863972"

    
    // App Tracking Transparency - Request permission and play ads on open only
    private func loadInterstitialAd() {

        // Tracking authorization completed. Start loading ads here.
        let request = GADRequest()
            GADInterstitialAd.load(
                withAdUnitID: googleBannerInterstitialAdID,
                request: request,
                completionHandler: { [self] ad, error in
                    
                    // Check if there is an error
                    if let error = error {
                        return
                    }
                    interstitial = ad
                    let root = UIApplication.shared.windows.first?.rootViewController
                    self.interstitial?.present(fromRootViewController: root!)

                })
      }
    
    var body: some View {
        
        GeometryReader { geo in
        TabView {
           // First Screen
           // ------------
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    
                    Text("Calculator")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Image("graphic")
                        .resizable()
                        .frame(width: 70, height: 35)
                        
                }
                .padding(.leading)
                .padding(.trailing)
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
            .onAppear {
                InterstitialAdCounter += 1
            }

            // Screen
            // // // // // //
            tableViewScreen
            .onAppear {
                InterstitialAdCounter += 1
            }
            .tabItem {
                Image(systemName: "lock").frame(width: 15, height: 15, alignment: .center)
                Text("Recipes")
            }
            
            
            // Screen
            // // // // // //
            InAppStorePurchasesView()
                .environmentObject(vm)
                .frame(width: geo.size.width * 0.9)
                .tabItem {
                    Image(systemName: "lock").frame(width: 15, height: 15, alignment: .center)
                    Text("Remove Ads")
                }
    
        }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .resultsView:
                if let recipe = vm.ediblyCalc {
                    ResultsView()
                        .environmentObject(vm)
                }
                
            case .decarbView:
                DecarbExplanationQuestionMarkView()
            }
        }
            
    }
    
}



extension EdiblyView {
    
    func checkIfCalculateButtonIsDisabled() -> Bool {
        if vm.ediblyCalc.weight == "" {
            return true
        }
        
        if vm.ediblyCalc.strainName == "" {
            return true
        }
        
        if vm.ediblyCalc.cupsOfBase == "" {
            return true
        }
        
        if vm.ediblyCalc.thc == "" {
            return true
        }
        
        if vm.ediblyCalc.cbd == "" {
            return true
        }
        
        return false
    }
    
    func returnStrainNameErrorMessage(recipeName: String) -> Bool {
        
        if vm.allRecipes.contains(where: { $0.strainName == recipeName}) {
            return true
        }
        
        return false
    }
    
    
    var InputForm: some View {
        Form {
            Section(header: Text("Inputs").foregroundColor(Color.theme.formTitleColor)) {
                VStack(alignment: .center) {
                    TextField("Cultivar Name", text: $vm.ediblyCalc.strainName)
                        .multilineTextAlignment(.center)
                    
                    if returnStrainNameErrorMessage(recipeName: vm.ediblyCalc.strainName) {
                        Text("Must enter unique Culitvar Name")
                            .font(.caption2)
                            .foregroundColor(Color.red)
                            .animation(.easeInOut(duration: 0.5))
                    }
                        
                }
                .padding(.vertical, 5)
                HStack(alignment: .center) {
                    Text("Grams of cannabis")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("Grams", text: $vm.ediblyCalc.weight)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        
                }
                .padding(.vertical, 5)
                HStack(alignment: .center) {
                    Text("THC percentage")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("THC %", text: $vm.ediblyCalc.thc)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                .padding(.vertical, 5)
                HStack(alignment: .center) {
                    Text("CBD percentage")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("CBD %", text: $vm.ediblyCalc.cbd)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                .padding(.vertical, 5)
                TextEditor(text: $vm.ediblyCalc.recipeNotes)
                    .multilineTextAlignment(.center)
                
                    
            }
            .padding(.top)

            
            Section(header: Text("Base").foregroundColor(Color.theme.formTitleColor)) {
                HStack(alignment: .center) {
                    Text("Cups of Base")
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    TextField("Cups", text: $vm.ediblyCalc.cupsOfBase)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                .padding(.vertical, 5)
            }
            
            
            Section(header: Text("Conversion Factor: " + String(format: "%.0f", sliderValue)).foregroundColor(Color.theme.formTitleColor)) {
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
            
            Section {
             
                Button(action: {
                    activeSheet = .resultsView
                  
                }) {
                    
                    Text(checkIfCalculateButtonIsDisabled() ? "All Inputs Required" : "Do The Calculation")
                        .foregroundColor(checkIfCalculateButtonIsDisabled() ? Color.theme.secondaryText : Color.theme.darkGreen )
                        .fontWeight(.bold)
                        
                }
                
                .disabled(checkIfCalculateButtonIsDisabled())
                .opacity(checkIfCalculateButtonIsDisabled() ? 0.5 : 1.0)

                Button(action: {
     
                    sliderValue = 70
                    vm.clearAllInputs()
                    
                    
                }) {
                    Text("Clear All Inputs")
                        .foregroundColor(Color.theme.darkGreen )
                        .fontWeight(.heavy)
                }
            }
        }
        .background(
            ZStack {
                Image("flower")
                    .resizable()
                    .scaledToFill()
                gradient
                    .opacity(0.85)
            })
    }
    
    var tableViewScreen: some View {
        GeometryReader { geo in
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
                        .frame(width: geo.size.width * 0.3)
                    Spacer()
                    Text("THC")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.caption)
                        .frame(width: geo.size.width * 0.13)
                    Text("CBD")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.caption)
                        .frame(width: geo.size.width * 0.13)
                    Text("Grams")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.caption)
                        .frame(width: geo.size.width * 0.13)
                    Text("Menu")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondaryText)
                        .font(.caption)
                        .frame(width: geo.size.width * 0.13)
                }
                
                
                
                ForEach(vm.allRecipes, id: \.self) { recipe in
 
                    HStack() {
                        Text(recipe.strainName)
                            .fontWeight(.medium)
                            .frame(width: geo.size.width * 0.3)
                        Spacer()
                        Text("\(recipe.thc)%")
                            .frame(width: geo.size.width * 0.13)
                        Text("\(recipe.cbd)%")
                            .frame(width: geo.size.width * 0.13)
                        Text("\(recipe.weight) g")
                            .frame(width: geo.size.width * 0.13)
                        LibraryMenuView(recipe: recipe)
                            .environmentObject(vm)
                            .frame(width: geo.size.width * 0.13)
                            
                    }
                    .padding(.vertical, 7)
                    
                    
                }
            }
            Banner()
                .environmentObject(vm)
        }
        .onDisappear {
            vm.clearAllInputs()
        }
        }
    }
}

struct EdiblyView_Previews: PreviewProvider {
    static var previews: some View {
        EdiblyView()
    }
}

