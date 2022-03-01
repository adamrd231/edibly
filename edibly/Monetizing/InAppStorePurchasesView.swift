//
//  InAppStorePurchasesView.swift
//  edibly
//
//  Created by Adam Reed on 9/11/21.
//

import SwiftUI

struct InAppStorePurchasesView: View {
    
    // Edible calculator object for running program
    @EnvironmentObject var vm: EdiblyViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("In-App Purchases")
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Spacer()
                    Button(action: {
                        // Restore already purchased products
                        vm.storeManager.restoreProducts()
                    }) {
                        Text("Restore Purchases")
                    }
                }
                .padding(.top)
                .padding(.vertical)

                
                // Loop through products that were added on App start, layout using list
                ForEach(vm.myProducts, id: \.self) { product in
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("\(product.localizedTitle)").font(.title3)
                            Text("$\(product.price)").font(.subheadline)
                            Text("\(product.localizedDescription)").font(.footnote).fixedSize(horizontal: false, vertical: true)
                        }
                        // Button to purchase product
                        Button( action: {
                            vm.storeManager.purchaseProduct(product: product)
                        }) {
                            // Update button text based on user purchase history
                            Text(vm.removedAdvertising == true ? "Purchased" : "Purchase").font(.title3)
                                .padding()
                                .background(vm.removedAdvertising == true ? Color.theme.background : Color.theme.darkGreen)
                                .foregroundColor(.white)
                                .cornerRadius(15.0)
                            
                            
                        }
                        // Disable the purchase button if purchase has already been made
                        .disabled(vm.removedAdvertising)
                    }
                }
                Spacer()
                
                // About me, the developer container
                VStack(alignment: .leading) {
                    Text("Thank you!").font(.title3).bold().padding(.top)
                    Text("As a independent Developer my income is made through advertising and in-app purchases offered by apps I've developed. Purchasing this feature allows me to continue working more on projects and apps. ").font(.footnote)
                }
                .padding(.bottom)
              
            }
            // Styling for main container
    


        }
    }
}

struct InAppStorePurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        InAppStorePurchasesView()
    }
}
