//
//  OffersView.swift
//  AMalysIT
//
//  Created by aycan duskun on 19.06.2024.
//

import SwiftUI

struct OffersView: View {
    @State var sellerInfo: Offers?
    
    var body: some View {
        NavigationStack {
            List {
                HStack{
                    Spacer()
                        .frame(width: 30)
                    Text("Seller")
                    Text("Stock")
                    Text("Price")
                }
                VStack{
                    ForEach(1...10, id: \.self) { index in
                        Text(String(index))
                        Spacer()
                            .frame(width: 10)
                    }
                   
                }
            }
        }
    }
}

#Preview {
    OffersView()
}
