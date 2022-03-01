//
//  EdiblyViewModel.swift
//  edibly
//
//  Created by Adam Reed on 2/25/22.
//

import Foundation
import SwiftUI
import Combine
import StoreKit

class EdiblyViewModel: ObservableObject {
    
    @Published var ediblyCalc = EdibleCalcModel()
    
    @Published var allRecipes: [EdibleCalcModel] = []
    
    let recipeDataService = RecipeDataService()
    
    
    
    
    @Published var storeManager: StoreManager = StoreManager()
    @Published var myProducts:[SKProduct] = []
    @Published var removedAdvertising: Bool = false
    
    var productIds = ["hideAdvertising"]
   
    
    private func setupStoreManager() {
        print("setting up store manager")
        if storeManager.myProducts.isEmpty {
            print("storemanager products is empty")
            SKPaymentQueue.default().add(storeManager)
            storeManager.getProducts(productIDs: productIds)
            
        }
        print("\(storeManager.myProducts.count)")
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        setupStoreManager()
    }
    
    
    
    func addSubscribers() {
        recipeDataService.$savedEntities
            .map(mapRecipeEntityToObjects)
            .sink { (returnedRecipes) in
                self.allRecipes = returnedRecipes
            }
            .store(in: &cancellables)
        
        storeManager.$myProducts
            .sink { returnedProducts in
                self.myProducts = returnedProducts
            }
            .store(in: &cancellables)
        
        storeManager.$purchasedRemoveAds
            .sink { purchasedAds in
                self.removedAdvertising = purchasedAds
            }
            .store(in: &cancellables)
        
        
    }
    
    func mapRecipeEntityToObjects(recipeEntity: [Recipe]) -> [EdibleCalcModel] {
        var newArray: [EdibleCalcModel] = []
        
        for recipe in recipeEntity {
            let newObject = EdibleCalcModel(id: recipe.id ?? UUID(),
                                            strainName: recipe.strainName ?? "",
                                            recipeNotes: recipe.recipeNotes ?? "",
                                            thc: recipe.thc ?? "",
                                            cbd: recipe.cbd ?? "",
                                            weight: recipe.weight ?? "",
                                            cupsOfBase: recipe.cupsOfBase ?? "",
                                            unitsInBatch: recipe.unitsInBatch ?? "",
                                            conversionFactor: recipe.conversionFactor ?? 70)
            
            newArray.append(newObject)
        }
        
        return newArray
    }
    
    
    func clearAllInputs() {
        print("clean inputs")
        ediblyCalc.thc = ""
        ediblyCalc.cbd = ""
        ediblyCalc.weight = ""
        ediblyCalc.strainName = ""
        ediblyCalc.recipeNotes = "Recipe Notes:"
        ediblyCalc.conversionFactor = 70
        ediblyCalc.cupsOfBase = ""
    }
    
}
