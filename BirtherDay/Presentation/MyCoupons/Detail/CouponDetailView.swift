//
//  CouponDeatilView.swift
//  BirtherDay
//
//  Created by Rama on 6/5/25.
//

import SwiftUI

struct CouponDetailView: View {
    
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    var viewModel: CouponDetailViewModel
    
    @State private var buttonTitle: String = "사용하기"
    @State var isShownPopup: Bool = false
    @State private var showShareModal = false           // 공유하기 뷰
    @State var buttonType: BDButtonType = .deactivate
    
    private let shareModalHeight: CGFloat = 195
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                DetailedCoupon(couponData: viewModel.selectedCoupon)
                    .padding(.top, 11)
            }
            .background(viewModel.selectedCoupon.template.backgroundColor)
            .scrollIndicators(.hidden)
            
            if !viewModel.selectedCoupon.isUsed { // 미사용일 때
                if viewModel.couponType == CouponType.received { // 내가 받은 쿠폰에서 미사용일 때 공유 버튼 제거
                    noShareButtonView()
                } else {
                    buttonsView() // 내가 보낸 쿠폰에서 미사용 일 때 공유 버튼 활성화
                }
            }
            
            if isShownPopup {
                popupView()
            }
        }
        .onAppear {
            print("viewModel.startupMPC() 실행")
            viewModel.startupMPC()
        }
        .onDisappear {
            print("ondisappear called")
        }
        .bdNavigationBar(
            title: "쿠폰 상세보기",
            backButtonAction: {
                viewModel.stopMPC()
                navPathManager.popPath()
            })
        .onChange(of: viewModel.mpc?.mpcSessionState) { oldValue, newValue in
            // mpc seesion state에 따른 버튼 타입 설정
            switch newValue {
            case .connected:
                buttonType = .activate
            case .notConnected, .connecting:
                buttonType = .deactivate
            case .none:
                buttonType = .deactivate
            case .some(_):
                buttonType = .deactivate
            }
        }
        .sheet(isPresented: $showShareModal) {
            shareModalView()
                .presentationDetents([.height(shareModalHeight)])
        }
    }
    
    func buttonsView()-> some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    
                } label: {
                    Text("공유")
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
                
                Button {
                    print("coupondetailview : \(viewModel.isConnectWithPeer)")
                    
                    // mpc seesion state에 따른 사용하기 버튼 액션 관리
                    if let mpc = viewModel.mpc {
                        print("Button pressed")
                        switch mpc.mpcSessionState {
                        case .notConnected:
                            isShownPopup.toggle()
                        case .connecting:
                            buttonTitle = mpc.mpcSessionState.displayString
                        case .connected:
                            buttonTitle = "사용하기"
                            navPathManager.pushMyCouponPath(.interaction(viewModel: viewModel))
                        @unknown default:
                            print("")
                        }
                    }
                    
                } label: {
                    Text(buttonTitle)
                }
                .buttonStyle(BDButtonStyle(buttonType: buttonType))
            }
            .padding(.top, 37)
            .padding(.horizontal, 16)
            .background(viewModel.selectedCoupon.template.buttonBackgroundColor.ignoresSafeArea())
        }
    }
    
    func noShareButtonView()-> some View {
        VStack {
            Spacer()
            
            useButtonView()
                .padding(.top, 37)
                .padding(.horizontal, 16)
                .background(viewModel.selectedCoupon.template.buttonBackgroundColor.ignoresSafeArea())
        }
    }

    func useButtonView() -> some View {
        Button {
            if let mpc = viewModel.mpc {
                switch mpc.mpcSessionState {
                case .notConnected:
                    isShownPopup.toggle()
                case .connecting:
                    buttonTitle = mpc.mpcSessionState.displayString
                case .connected:
                    buttonTitle = "사용하기"
                    navPathManager.pushMyCouponPath(.interaction(viewModel: viewModel))
                @unknown default:
                    break
                }
            }
            
        } label: {
            Text(buttonTitle)
        }
        .buttonStyle(BDButtonStyle(buttonType: viewModel.isConnectWithPeer ? .activate : .deactivate))
    }
    
    func shareButtonView() -> some View {
        Button {
            showShareModal.toggle()
        } label: {
            Label("공유", systemImage: "square.and.arrow.up")
        }
        .buttonStyle(BDButtonStyle(buttonType: .share))
    }
    
    func shareModalView() -> some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(
                    width: 40,
                    height: 5
                )
                .padding(.top, 2)
            
            Text("공유하기")
                .font(.b2)
                .padding(.top, 16)
            
            ShareButtons(
                couponId: viewModel.selectedCoupon.couponId,
                senderName: viewModel.selectedCoupon.senderName
            )
            .padding(.top, 24)
        }
    }
    
    func popupView() -> some View {
        ZStack {
            Color.bgDimmed.ignoresSafeArea(.all)
            VStack {
                Text("쿠폰을 준 사람과 받은 사람의\n거리가 가까울 경우 사용 가능해요")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.textBody)
                    .padding(.top, 43)
                    .padding(.bottom, 30)
                Rectangle().frame(height: 1).foregroundStyle(.bar)
                
                // TODO: - 터치 영역 늘리기
                Button {
                    self.isShownPopup = false
                } label: {
                    Text("확인")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .contentShape(Rectangle())
                }
                .foregroundStyle(Color.mainPrimary)
                .font(.m2)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 44)
        }
    }
}

//#Preview {
//    CouponDetailView(viewModel: CouponDetailViewModel(selectedCoupon: .stub01))
//        .environmentObject(BDNavigationPathManager())
//}
