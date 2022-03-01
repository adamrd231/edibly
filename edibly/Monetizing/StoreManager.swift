//
//  StoreManager.swift
//  adamsCalc
//
//  Created by Adam Reed on 6/29/21.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // Variable for holding products that are available to users for sale
    @Published var myProducts = [SKProduct]()
    
    // Create a product request object to manage store API
    var request: SKProductsRequest!
    
    // Create a state to manage at which point the purchase is in
    @Published var transactionState: SKPaymentTransactionState?
    
    // Variable to check if user has purchased ads (without internet) saved using userdefaults
    @Published var purchasedRemoveAds = UserDefaults.standard.bool(forKey: "purchasedRemoveAds") {
        // If variable changes, update user defaults with last change
        didSet {
            UserDefaults.standard.setValue(self.purchasedRemoveAds, forKey: "purchasedRemoveAds")
        }
    }
    
//    @Published var purchasedRemoveAds = true
    
    // Get all products from App Store connect and store in myproducts variable
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // Check if response is not empty
        if !response.products.isEmpty {
            // Loop through products
            print("Reqeusting prodcuts")
            for fetchedProduct in response.products {
                // Grab main thread for UI updates
                DispatchQueue.main.async {
                    // update variable with all products found in loop
                    self.myProducts.append(fetchedProduct)
                }
            }
        }
        // If identifier is invalid throw a print statement
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    // Get products from app store connect, create request and call it to run
    func getProducts(productIDs: [String]) {
        print("Start requesting products ...")
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }

    // Function to update transaction state with recent transactions
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                purchasedRemoveAds = true
                transactionState = .purchased
            case .restored:
                UserDefaults.standard.setValue(true, forKey: transaction.payment.productIdentifier)
                queue.finishTransaction(transaction)
                purchasedRemoveAds = true
                transactionState = .restored
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                    queue.finishTransaction(transaction)
                    transactionState = .failed
                    default:
                    queue.finishTransaction(transaction)
            }
        }
    }
    
    // Let the user try to purchase the product
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    // Restore any previously purchased transactions
    func restoreProducts() {
        print("Restoring products ...")
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
}
