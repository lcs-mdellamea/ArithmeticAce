//
//  MultiplicationView.swift
//  ArithmeticAce
//
//  Created by Russell Gordon on 2022-02-07.
//

import SwiftUI

struct MultiplicationView: View {
    
    // MARK: Stored properties
    @State var multiplicand = Int.random(in: 1...12)
    @State var multiplier = Int.random(in: 1...12)
    
    //This string contains whatever the user types in.
    @State var inputGiven = ""
    @State var newQuestion = false
    
    // Has an answer been checked?
    @State var answerChecked = false
    
    // Was the answer given actually correct?
    @State var answerCorrect = false
    
    // MARK: Computed properties
    // What is the correct product?
    var correctProduct: Int {
        return multiplicand * multiplier
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("✕")
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(multiplicand)")
                    Text("\(multiplier)")
                }
            }
            
            Divider()
            
            HStack {
                ZStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    //        CONDITION      true  false
                        .opacity(answerCorrect ? 1.0 : 0.0)
                        .opacity(newQuestion ? 1.0 : 0.0)
                    Image(systemName: "x.circle")
                        .foregroundColor(.red)
                    //        CONDITION      true  false
                        .opacity(answerChecked == true && answerCorrect == false ? 1.0 : 0.0)
                    
                    
                    Spacer()
                    TextField("",
                              text: $inputGiven)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            //Check Answer Button
            
            ZStack {
                Button(action: {
                    
                    // Answer has been checked!
                    answerChecked = true
                    
                    // Convert the input given to an integer, if possible
                    guard let productGiven = Int(inputGiven) else {
                        // Sadness, not a number
                        answerCorrect = false
                        return
                    }
                    
                    // Check the answer!
                    if productGiven == correctProduct {
                        // Celebrate! 👍🏼
                        answerCorrect = true
                    } else {
                        // Sadness, they gave a number, but it's not correct 😭
                        answerCorrect = false
                    }
                }, label: {
                    Text("Check Answer")
                        .font(.largeTitle)
                })
                    .padding()
                    .buttonStyle(.bordered)
                //Only show this button when an answer has not been checked.
                    .opacity(answerChecked == false ? 1.0 : 0.0)
                
                //New Question Button
                
                Button(action: {
                    
                    // New Quesetion!
                    newQuestion = true
                    
                    //Reset properties that check what's happening with the current question.
                    answerChecked = false
                    answerCorrect = false
                    
                    //Reset the inuput field
                    inputGiven = ""
                    
                    //New Question
                    multiplicand = Int.random(in: 1...12)
                    multiplier = Int.random(in: 1...12)
                    
                    
                }, label: {
                    Text("New Question")
                        .font(.largeTitle)
                })
                    .padding()
                    .buttonStyle(.bordered)
                //Only show this button when an answer has been checked.
                    .opacity(answerChecked == true ? 1.0 : 0.0)
            }
        }
        .padding(.horizontal)
        .font(.system(size: 72))
        
        
    }
}

struct MultiplicationView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationView()
    }
}
