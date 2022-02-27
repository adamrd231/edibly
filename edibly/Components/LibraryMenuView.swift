//
//  LibraryMenuView.swift
//  edibly
//
//  Created by Adam Reed on 2/26/22.
//

import SwiftUI

struct LibraryMenuView: View {
    
    @EnvironmentObject var vm: EdiblyViewModel
    @State var recipe: EdibleCalcModel
    
    @State var activeSheet: ActiveSheet?
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case decarbView, resultsView
        
        var id: Int {
            hashValue
        }
    }
    
    
    var body: some View {
        Menu(content: {
            HStack {
                Button(action: {
                    vm.ediblyCalc = recipe
                    activeSheet = .resultsView
                }) {
                    Text("Go to Recipe").foregroundColor(.red)
                    Spacer()
                    Image(systemName: "line.diagonal.arrow").foregroundColor(.red)
                }
                Button(action: {
                    print("Deleting \(recipe.strainName)")
                    vm.recipeDataService.delete(recipe: recipe)
                }) {
                    Text("Delete").foregroundColor(.red)
                    Spacer()
                    Image(systemName: "trash").foregroundColor(.red)
                }
            }
        }) {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.theme.darkGreen)
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

struct LibraryMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryMenuView(recipe: EdibleCalcModel())
    }
}
