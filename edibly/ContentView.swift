//
//  ContentView.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
            // Setup backgound Color
            Color(.systemGray6).edgesIgnoringSafeArea([.top,.bottom])
            
                VStack(alignment: .center) {
                    Text("Just one thing.")
                        .font(.title)
                        .bold()
                        
                    Text("In order to use this app you must be twenty one years or older. Keep out of the reach of children, Do not operate machinery under the influence, edible effects can be delayed for up to two hours, please recreate responsibly.")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                        
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        TwentyOneButton()
                    }
                    Button(action: {
                        
                    }) {
                        NotTwentyOneButton()
                    }
                }.padding()
            }
            .navigationTitle("Welcome to Edibly,")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
