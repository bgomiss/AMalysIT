//
//  NavigationBarTitle.swift
//  AMalysIT
//
//  Created by aycan duskun on 27.05.2024.
//

import SwiftUI

struct CustomNavigationBarTitle: View {
    var body: some View {
        HStack {
            Spacer()
            Text("AmalysIT")
                .font(.title)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}
