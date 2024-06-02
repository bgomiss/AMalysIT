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
    var width: CGFloat
    var height: CGFloat
    var aspectRatio: ContentMode
    var backgroundColor: Color
    var cornerRadius: CGFloat
    
//    init(urlStrings: [String]) {
//        self.urlStrings = urlStrings
//        _viewModel = StateObject(wrappedValue: URLImageViewModel(urlStrings: urlStrings))
//    }
    
    init(urlStrings: [String], width: CGFloat = 100, height: CGFloat = 100, aspectRatio: ContentMode = .fill, backgroundColor: Color = .gray, cornerRadius: CGFloat = 8) {
            self.urlStrings = urlStrings
            self.width = width
            self.height = height
            self.aspectRatio = aspectRatio
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            _viewModel = StateObject(wrappedValue: URLImageViewModel(urlStrings: urlStrings))
        }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(urlStrings.indices, id: \.self) { index in
                    if let data = viewModel.data[index], let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: aspectRatio)
                            .frame(width: width, height: height)
                            .background(backgroundColor)
                            .cornerRadius(cornerRadius)
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
