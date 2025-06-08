//
//  BDAllMiniCoupon.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/7/25.
//

import SwiftUI

struct BDAllMiniCoupon: View {
    var body: some View {
        VStack(spacing: 0) {
            couponMainView()
            couponInfoView()
        }
        .foregroundStyle(Color.mainViolet100)
    }
    
    // MARK: - Views
    /// 메인 쿠폰
    func couponMainView()-> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 15)
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Text("?")
                  .font(
                    Font.custom("Pretendard", size: 64)
                      .weight(.semibold)
                  )
                  .foregroundStyle(Color.gray)
                  .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                dashedLineView(color: Color.mainViolet300)
            }
        }
        .frame(width: 165, height: 157)
    }
    
    /// 점선
    func dashedLineView(color: Color)-> some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 15, y: 0))
                path.addLine(to: CGPoint(x: 150, y: 0))
            }
            .stroke(
                Color.mainViolet100
            )
            .frame(height: 1)
            
            
            Path { path in
                path.move(to: CGPoint(x: 15, y: 0))
                path.addLine(to: CGPoint(x: 150, y: 0))
            }
            .stroke(
                color,
                style: StrokeStyle(lineWidth: 2, dash: [8, 6])
            )
            .frame(height: 1)
        }
    }
    
    /// 쿠폰 정보
    func couponInfoView()-> some View {
        
        return ZStack {
            RoundedRectangle(cornerRadius: 15)
            VStack(alignment: .center, spacing: 0) {
                HStack(spacing: 0) {
                    Text("쿠폰 전체보기")
                    Image(systemName: "chevron.right")
                        .imageScale(.small)
                }
                .foregroundStyle(Color.textCaption1)
                .font(.sb1)
            }
        }
        .frame(width: 164, height: 113)
    }
}

#Preview {
    BDAllMiniCoupon()
}
