//
//  EdiblyViewModel.swift
//  edibly
//
//  Created by Adam Reed on 2/25/22.
//

import Foundation
import SwiftUI
import Combine

class EdiblyViewModel: ObservableObject {
    
    @Published var ediblyCalc = EdibleCalcModel()
    
    @Published var allRecipes: [EdibleCalcModel] = []
    
    let recipeDataService = RecipeDataService()
    
    // Store Manager object to make In App Purchases
    @Published var storeManager = StoreManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        recipeDataService.$savedEntities
            .map(mapRecipeEntityToObjects)
            .sink { (returnedRecipes) in
                self.allRecipes = returnedRecipes
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
    
}
