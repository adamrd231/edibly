//
//  InAppStorePurchasesView.swift
//  edibly
//
//  Created by Adam Reed on 9/11/21.
//

import SwiftUI

struct InAppStorePurchasesView: View {
    
    // Edible calculator object for running program
//    @EnvironmentObject var vm: EdiblyCalc
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Loop through products that were added on App start, layout using list
//                List(storeManager.myProducts, id: \.self) { product in
//                    VStack(alignment: .leading) {
//                        VStack(alignment: .leading) {
//                            Text("\(product.localizedTitle)").font(.title3)
//                            Text("$\(product.price)").font(.subheadline)
//                            Text("\(product.localizedDescription)").font(.footnote).fixedSize(horizontal: false, vertical: true)
//                        }.padding(.bottom)
//
//                        // Button to purchase product
//                        Button( action: {
//                            storeManager.purchaseProduct(product: product)
//                        }) {
//                            VStack {
//                                // Update button text based on user purchase history
//                                if storeManager.purchasedRemoveAds == true {
//                                    Text("Purchased")
//                                } else {
//                                    // information about the purchase
//                                    Text(storeManager.myProducts.first?.localizedTitle ?? "Not Available").font(.title3)
//                                        .frame(minWidth: 300, idealWidth: .infinity, maxWidth: .infinity, minHeight: 35, idealHeight: 45, maxHeight: 55, alignment: .center)
//                                        .font(.system(size:15.0))
//                                        .background(Color("DarkMainColor"))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(15.0)
//
//                                }
//                            }
//                        }
//                        // Disable the purchase button if purchase has already been made
//                        .disabled(storeManager.purchasedRemoveAds)
//                    }
//                }
                
                // About me, the developer container
                VStack(alignment: .leading) {
                    Text("Thank you!").font(.title3).bold().padding(.top)
                    Text("As a independent Developer my income is made through advertising and in-app purchases offered by apps I've developed. Purchasing this feature allows me to continue working more on projects and apps. ").font(.footnote)
                    Text("New feature ideas and bug fixes are always welcome at 'adam@rdconcepts.design'").font(.footnote)
                }.padding(.top).padding(.bottom)
            }
            // Styling for main container
            .padding(.bottom)
            
            // Add Navigation Title
            .navigationTitle("In App Purchases")
            
            // Add toolbar item to navigation
            .toolbar(content: {
                ToolbarItem {
                    // Button for users to restore purchaes
                    Button(action: {
                        // Restore already purchased products
                        
          
                    }) {
                        Text("Restore Purchases")
                    }
                }
            })
        }
    }
}

struct InAppStorePurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        InAppStorePurchasesView()
    }
}
