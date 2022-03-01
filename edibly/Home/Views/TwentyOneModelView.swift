//
//  ContentView.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct TwentyOneModelView: View {
    
    @Binding var visited: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
        // Setup backgound Color
        Color.theme.background
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
                    withAnimation(.easeInOut(duration: 0.5)) {
                        visited.toggle()
                    }
                    
         
                }) {
                    TwentyOneButton()
                }
                Button(action: {
                    
                }) {
                    NotTwentyOneButton()
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwentyOneModelView(visited: .constant(false))
    }
}
