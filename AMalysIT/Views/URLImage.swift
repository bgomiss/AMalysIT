//
//  UrlImage.swift
//  AMalysIT
//
//  Created by aycan duskun on 23.05.2024.
//

import Foundation
import SwiftUI

struct URLImage: View {
    let urlStrings: [String]
    
    @StateObject private var viewModel: URLImageViewModel
    
    init(urlStrings: [String]) {
        self.urlStrings = urlStrings
        _viewModel = StateObject(wrappedValue: URLImageViewModel(urlStrings: urlStrings))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(urlStrings.indices, id: \.self) { index in
                    if let data = viewModel.data[index], let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .background(Color.gray)
                            .cornerRadius(8)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}
