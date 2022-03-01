//
//  RecipeDataService.swift
//  edibly
//
//  Created by Adam Reed on 2/26/22.
//

import Foundation
import CoreData

class RecipeDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "RecipeContainer"
    private let entityName: String = "Recipe"
    
    @Published var savedEntities: [Recipe] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(
                    """
                    Error loading core data:
                    \(error)
                    """
                )
            }
            self.getRecipes()
        }
        
    }
    
    func getRecipes() {
        let request = NSFetchRequest<Recipe>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching Portfolio: \(error)")
        }
    }
    
    func addRecipe(recipeEntered: EdibleCalcModel) {
        
        if let entity = savedEntities.first(where: { $0.strainName == recipeEntered.strainName }) {
            entity.thc = recipeEntered.thc
            entity.cbd = recipeEntered.cbd
            entity.cupsOfBase = recipeEntered.cupsOfBase
            entity.recipeNotes = recipeEntered.recipeNotes
            entity.weight = recipeEntered.weight
            entity.strainName = recipeEntered.strainName
            entity.unitsInBatch = recipeEntered.unitsInBatch
            entity.conversionFactor = recipeEntered.conversionFactor
        } else {
            let entity = Recipe(context: container.viewContext)
            entity.id = recipeEntered.id
            entity.thc = recipeEntered.thc
            entity.cbd = recipeEntered.cbd
            entity.cupsOfBase = recipeEntered.cupsOfBase
            entity.recipeNotes = recipeEntered.recipeNotes
            entity.weight = recipeEntered.weight
            entity.strainName = recipeEntered.strainName
            entity.unitsInBatch = recipeEntered.unitsInBatch
            entity.conversionFactor = recipeEntered.conversionFactor
        }
        applyChanges()
    }
    
     func delete(recipe: EdibleCalcModel) {
        
//        let recipe = savedEntities.first(where: { $0. })
        let entity = savedEntities.first(where: { $0.strainName == recipe.strainName })
        print(entity?.strainName)
        if let recipe = entity {
            container.viewContext.delete(recipe)
            applyChanges()
        }
        
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
            
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    
    private func applyChanges() {
        save()
        getRecipes()
    }
        
    
    
}
