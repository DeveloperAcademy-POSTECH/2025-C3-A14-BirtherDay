//
//  CompletedCouponView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI
import Kingfisher

struct CouponCompleteView: View {
    @ObservedObject var viewModel: CreateCouponViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.couponData.uploadedImagePaths, id: \.self) { path in
                    if let url = URL(string: path) {
                        KFImage.url(url)
                            .placeholder {
                                Image("placeholderImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                            }
                            .fade(duration: 0.25)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CouponCompleteView(viewModel: CreateCouponViewModel())
}
 
