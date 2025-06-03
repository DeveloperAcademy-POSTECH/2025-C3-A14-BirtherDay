//
//  TemplateView.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import SwiftUI

struct BDTemplateView: View {
    
    let type: CouponTemplate
    let sender: String = "주니"
    let date: String = "2025.06.01"
    
    var isShownSubtitleView = true           /// 하단 쿠폰을 보여줄지 정하는 프로퍼티
    var title = "나랑 저녁에 애슐리 먹으러 가자!"                      // 쿠폰 제목
    var subtitle = "쿠폰을 사용 중이에요👏"
    
    var body: some View {
        VStack(spacing: 0) {
            mainCouponView()
            if isShownSubtitleView {
                dashedLineView(basicColor: type.basicColor, dashLineColor: type.dashLineColor)
                subtitleView(subtitle: subtitle)
            }
        }
        .aspectRatio(isShownSubtitleView ? 32/53 : 32/43, contentMode: .fit)        // 하단 subtitle뷰 여부에 따른 쿠폰 가로세로 비율 고정
    }
    
    /// 메인 쿠폰 뷰
    func mainCouponView()-> some View {
        VStack(spacing: 30) {
            senderDateView()
            
            Spacer()
            
            // TODO: - Image 연결
            Rectangle()
                .frame(width: 200, height: 200)
            
            Spacer()
            
            titleView()
        }

        .padding(.vertical, 35)
        .padding(.horizontal, 27)
        .frame(minHeight: 320)
        .background {
            // 배경에 사용되는 circle + blur
            bluredCircleView()
        }
        .background(type.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(type.strokeColor, lineWidth: 1))
    }
    
    /// 전송자 및 만료날짜
    func senderDateView()-> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("From. \(sender)")
                .font(.sb3)
                .foregroundStyle(Color.textTitle)
            Text("\(date)까지")
                .font(.r3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// 쿠폰 배경에 사용되는 블러처리된 원형 뷰
    func bluredCircleView()-> some View {
        VStack(spacing: 0) {
            HStack {
                Circle().foregroundStyle(type.backgroundPointColor[0].opacity(0.8))
                    .blur(radius: 75)
                    .frame(width: 123, height: 123)
                Spacer()
            }
            
            Spacer()
                .frame(height: 37)
            HStack {
                Circle().foregroundStyle(type.backgroundPointColor[1].opacity(0.5))
                    .blur(radius: 75)
                    .frame(width: 204, height: 204)
                    .padding(.leading, -18)
                Spacer()
            }
            HStack {
                Spacer()
                Circle().foregroundStyle(type.backgroundPointColor[2].opacity(0.5))
                    .blur(radius: 75)
                    .frame(width: 204, height: 204)
                    .padding(.trailing, -40)
            }
        }
    }
    
    func titleView()-> some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .font(.sb4)
            .foregroundStyle(Color.textTitle)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    /// 점선 뷰 - basicColor: 쿠폰 배경색, dashLineColor: 점선색
    func dashedLineView(basicColor: Color, dashLineColor: Color)-> some View {
        ZStack {
            // 쿠폰 경계에 있는 외곽선 지우는 선
            Path { path in
                path.move(to: CGPoint(x: 30, y: 0)) // TODO: create radius & padding property
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 30, y: 0)) // 27*2 padding + 30 radius 고려
            }
            .stroke(basicColor)
            .frame(height: 1)
            
            // 점선
            Path { path in
                path.move(to: CGPoint(x: 30, y: 0)) // TODO: create radius & padding property
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 30, y: 0)) // 27*2 padding + 30 radius 고려
            }
            .stroke(
                dashLineColor,
                style: StrokeStyle(lineWidth: 2, dash: [10])
            )
            .frame(height: 1)
        }
    }
    
    /// 서브 타이틀 뷰
    func subtitleView(subtitle: String) -> some View {
        Text(subtitle)
            .font(.sb2)
            .foregroundStyle(Color.textTitle)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 38)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    
    }
}

#Preview {
    BDTemplateView(type: .orange)
}
