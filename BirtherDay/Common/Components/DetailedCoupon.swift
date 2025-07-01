//
//  CouponDetailView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI
import Kingfisher

struct DetailedCoupon: View {
    @State private var showPhotoZoomView: Bool = false
    @State private var selectedImageIndex: Int = 0
    
    var couponData: RetrieveCouponResponse
    var couponImages: [KFImage]
    
    init(
        couponData: RetrieveCouponResponse,
        images: [KFImage]
    ) {
        self.couponData = couponData
        self.couponImages = images
    }
    
    var body: some View {
        VStack(spacing: 0) {
            mainCouponView()
            
            dashedLineView(
                color: couponData.template.dashLineColor,
                color2: couponData.template.basicColor
            )
            
            if !couponData.imageList.isEmpty {
                subtitleView(subtitle: "📷 함께 첨부된 사진을 확인하세요!")
                dashedLineView(color: Color.gray200, color2: Color.white)
                imageListView()
                dashedLineView(color: Color.gray200, color2: Color.white)
            }
            
            subtitleView(subtitle: "💌 함께 도착한 편지를 읽어보세요!")
            dashedLineView(color: Color.gray200, color2: Color.white)
            letterView()
        }
        .padding(.horizontal, 27)
        .padding(.bottom, 133)
        .fullScreenCover(isPresented: $showPhotoZoomView) {
            PhotoZoomView(
                images: couponImages,
                initialIndex: selectedImageIndex,
                isPresented: $showPhotoZoomView
            )
        }
    }
    
    // 메인 쿠폰 뷰
    func mainCouponView()-> some View {
        BDTemplate(data: couponData)
    }
    
    // 점선 뷰
    func dashedLineView(color: Color, color2: Color)-> some View {
        ZStack {
            // 쿠폰 경계에 있는 외곽선 지우는 선
            Path { path in
                path.move(to: CGPoint(x: 30, y: 0)) // TODO: create radius & padding property
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 84, y: 0)) // 27*2 padding + 30 radius 고려
            }
            .stroke(color2)
            .frame(height: 1)
            
            // 점선
            Path { path in
                path.move(to: CGPoint(x: 30, y: 0)) // TODO: create radius & padding property
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 84, y: 0)) // 27*2 padding + 30 radius 고려
            }
            .stroke(
                color,
                style: StrokeStyle(lineWidth: 2, dash: [10])
            )
            .frame(height: 1)
        }
    }
    
    // 서브 타이틀 뷰
    func subtitleView(subtitle: String) -> some View {
        Text(subtitle)
            .font(.sb2)
            .foregroundStyle(Color.textTitle)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 38)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        
    }
    
    func imageListView() -> some View {
        ZStack {
            Color.white
            
            imageCarouselView()
                .padding(.top, 56)
                .padding(.bottom, 68)
        }
        .frame(minHeight: 430)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    func letterView() -> some View {
        ZStack {
            Color.white
            
            ScrollView {
                Text(couponData.letter)
                    .font(.sb2)
                    .foregroundStyle(Color.textTitle)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 26)
                    .padding(.vertical, 25)
            }
        }
        .frame(minHeight: 430)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    func imageCarouselView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                let urls = couponData.imageList.compactMap { URL(string: $0 ?? "")}
                ForEach(Array(couponImages.enumerated()), id: \.offset) { index, kfImage in
                    kfImage
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: 215,
                            height: 306
                        )
                        .clipped()
                        .cornerRadius(10)
                        .onTapGesture {
                            selectedImageIndex = index
                            showPhotoZoomView = true
                        }
                }
            }
            .padding(.horizontal, 50)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
