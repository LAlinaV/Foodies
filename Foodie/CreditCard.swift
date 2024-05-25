//
//  CreditCard.swift
//  Foodie
//
//  Created by Алина on 25.05.24.
//

import SwiftUI

struct CardFrontView: View {
    
    let creditCardInfo: CreditCardInfo
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .padding()
                Spacer()
                Text("VISA")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .italic()
                    .padding()
            }
            
            Text(creditCardInfo.cardNumber.isEmpty ? " ": creditCardInfo.cardNumber)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("CARD HOLDER")
                        .opacity(0.5)
                    .font(.system(size: 14))
                    Text(creditCardInfo.cardHolderName.isEmpty ? " ": creditCardInfo.cardHolderName)
                }
               
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("EXPIRES")
                        .opacity(0.5)
                    .font(.system(size: 14))
                    Text(creditCardInfo.expirationDate.isEmpty ? " ": creditCardInfo.expirationDate)
                }
                
            }.padding()
               
            Spacer()
        }
        .foregroundStyle(.white)
        .frame(width: 350, height: 250)
        .background {
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
    }
}

struct CreditCardInfo {
    var cardHolderName: String = ""
    var cardNumber: String = ""
    var expirationDate: String = ""
    var ccvCode: String = ""
}

struct CheckoutFormView: View {
    
    @Binding var creditCardInfo: CreditCardInfo
    let onCCVTapped: () -> Void
    @FocusState private var isCCVFocused: Bool
    
    var body: some View {
        Form {
            TextField("Cardholder's Name", text: $creditCardInfo.cardHolderName)
            TextField("Card Number", text: $creditCardInfo.cardNumber)
            TextField("Expiry Date", text: $creditCardInfo.expirationDate)
            TextField("CCV", text: $creditCardInfo.ccvCode)
                .focused($isCCVFocused)
                .onTapGesture {
                    isCCVFocused = true
                    onCCVTapped()
                }
        }
        
    }
}

struct CardBackView: View {
    
    let creditCardInfo: CreditCardInfo
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.black)
                .frame(maxWidth: .infinity, maxHeight: 22)
                .padding([.top], 20)
            
            Spacer()
            
            HStack {
                
                Text(" \(creditCardInfo.ccvCode)")
                    .frame(width: 100, height: 33, alignment: .leading)
                    .background(.white)
                    .foregroundStyle(.black)
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    ).padding([.leading, .trailing, .bottom], 20)
                
               
                Spacer()
            }
                
                
        }
        .foregroundStyle(.white)
        .frame(width: 350, height: 250)
        .background {
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
    }
}

struct CreditCard: View {
   
    @State private var creditCardInfo = CreditCardInfo()
    @State private var flip: Bool = false
    @State private var degrees: Double = 0
    
    var body: some View {
        VStack {
            
            VStack {
                if !flip {
                    CardFrontView(creditCardInfo: creditCardInfo)
                    
                } else {
                    CardBackView(creditCardInfo: creditCardInfo)
                }
            }.rotation3DEffect(
                .degrees(degrees),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            Spacer()
            CheckoutFormView(creditCardInfo: $creditCardInfo, onCCVTapped: {
                withAnimation {
                    degrees += 180
                    flip.toggle()
                }
            })
        } .frame(height:600)
    }
}

struct CreditCard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreditCard()
        }
    }
}
