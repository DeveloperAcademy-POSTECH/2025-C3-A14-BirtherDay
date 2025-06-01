//
//  CouponDetailView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI

struct CouponDetailView: View {
    
    var viewModel: CouponDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                mainCouponView()
                dashedLineView(color: .orange)
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
        .background(Color(hex: "FFF4F4").ignoresSafeArea(.all)) // TODO: - 컬러칩 등록되면 수정하기
        .scrollIndicators(.hidden)
    }
    
    // 메인 쿠폰 뷰
    func mainCouponView()-> some View {
        // TODO: - change state and font
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
//                Text("From. \(viewModel.coupon.senderName)")
                Text("From. 주니")
                    .font(.sb3)
                    .foregroundStyle(Color.textTitle)
                Text("\(viewModel.expireDateString)까지")
                    .font(.r3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer(minLength: 0)
            
            Rectangle()
                .frame(width: 150, height: 150)
            
            Spacer(minLength: 0)
            
            Text("함께 만나서 사용할 쿠폰 입력해주세요!")
                .frame(maxWidth: .infinity)
                .font(.sb4)
                .foregroundStyle(Color.textTitle)
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .frame(minHeight: 430)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 17)
        .padding(.top, 31)
        .padding(.bottom, 35)
        .background {
            VStack(spacing: 0) {
                HStack {
                    Circle().foregroundStyle(Color(hex: "FFD586").opacity(0.8))
                        .blur(radius: 75)
                        .frame(width: 123, height: 123)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 37)
                HStack {
                    Circle().foregroundStyle(Color(hex: "FFAE86").opacity(0.5))
                        .blur(radius: 75)
                        .frame(width: 204, height: 204)
                        .padding(.leading, -18)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Circle().foregroundStyle(Color(hex: "FFED86").opacity(0.5))
                        .blur(radius: 75)
                        .frame(width: 204, height: 204)
                        .padding(.trailing, -40)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(LinearGradient.templateStroke1, lineWidth: 1))
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
