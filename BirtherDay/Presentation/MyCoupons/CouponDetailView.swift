//
//  CouponDetailView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI

struct CouponDetailView: View {
    
    var viewModel: CouponDetailViewModel
    var templateType: CouponTemplate = .blue    // TODO: - viewmodel로 옮기기
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                mainCouponView()
                dashedLineView(color: templateType.dashLineColor)
                subtitleView(subtitle: "📷 함께 첨부된 사진을 확인하세요!")
                dashedLineView(color: Color.gray200)
                imageListView()
                dashedLineView(color: Color.gray200)
                subtitleView(subtitle: "💌 함께 도착한 편지를 읽어보세요!")
                dashedLineView(color: Color.gray200)
                letterView()
            }
            .padding(.horizontal, 27)
        }
        .background(templateType.backgroundColor.ignoresSafeArea(.all)) // TODO: - 컬러칩 등록되면 수정하기
        .scrollIndicators(.hidden)
    }
    
    // 메인 쿠폰 뷰
    func mainCouponView()-> some View {
        BDTemplateView(type: .blue)    // TODO: 모델 연결
    }
    
    // 점선 뷰
    func dashedLineView(color: Color)-> some View {
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
    
    // TODO: - 첨부한 이미지 뷰
    func imageListView() -> some View {
        VStack {
            Color.white
        }
        .frame(minHeight: 430)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    // TODO: - 편지 뷰
    func letterView() -> some View {
        VStack {
            Color.white
        }
        .frame(minHeight: 430)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    CouponDetailView(viewModel: CouponDetailViewModel(coupon: .stub01))
}
