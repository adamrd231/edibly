//
//  ExplanationSheet.swift
//  edibly
//
//  Created by Adam Reed on 7/11/21.
//

import SwiftUI

struct DecarbExplanationQuestionMarkView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("How it works.").bold()
                    Text("This calculator does not factor in decarboxylation loss. Decarboxylation is the process of heating cannabis to activate the cannabinoids within its bud. However, when flower is heated to perform the carboxylation process, it also loses a percentage of the cannabinoids. We added the conversion factor in order to try to accurately reflect what will be cooked into the final product.")
                    Text("Additionally, when infusing into coconut oil, butter, etc.. A percentage of the THC will be left behind no matter the process. Using the conversion factor you can learn more about your techniques and more accurately predict potency.")
                }
                
                VStack(alignment: .leading) {
                    Text("How it works.").bold()
                    Text("THC% * Weight * Conversion Factor / Number of Units")
                }.padding(.top)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("DISMISS").foregroundColor(.white).bold()
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 30, idealHeight: 30, maxHeight: 30, alignment: .center)
                        .padding()
                        .font(.system(size: 20))
                        .background(Color("MainColor"))
                        .cornerRadius(20)
                        
                }
                
            }.padding()
        }.padding()
    }
}

struct ExplanationSheet_Previews: PreviewProvider {
    static var previews: some View {
        DecarbExplanationQuestionMarkView()
    }
}
