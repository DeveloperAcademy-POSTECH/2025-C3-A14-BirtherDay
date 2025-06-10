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
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var buttonTitle: String = "사용하기"
    @State var isShowPopup: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                DetailedCoupon(couponData: viewModel.selectedCoupon)
                    .padding(.top, 11)
            }
            
            .background(viewModel.selectedCoupon.template.backgroundColor)
            .scrollIndicators(.hidden)
            .bdNavigationBar(
                title: "쿠폰 상세보기",
                backButtonAction: navPathManager.popPath,
                color: UIColor(
                    viewModel.selectedCoupon.template.backgroundColor
                )
            )
            
            buttonsView()
            
            if isShowPopup {
                popupView()
            }
        }
        .onAppear {
            print("viewModel.startupMPC()")
//            viewModel.startupMPC()
        }
        .navigationBarBackButtonHidden()
//        .bdNavigationBar(title: "쿠폰 상세보기") {
//            viewModel.stopMPC()
//            navPathManager.popPath()
//        }
        .onDisappear {
            print("ondisappear called")
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            switch scenePhase {
            case .active:
                viewModel.startupMPC()
            case .background, .inactive:
//                viewModel.stopMPC()
                print("background, inactive")
            @unknown default:
                break
            }
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
                    if let mpc = viewModel.mpc {
                        switch mpc.mpcSessionState {
                        case .notConnected:
                            isShowPopup.toggle()
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
            .padding(.top, 37)
            .padding(.horizontal, 16)
            .background(viewModel.selectedCoupon.template.buttonBackgroundColor.ignoresSafeArea())
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
                    self.isShowPopup = false
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

#Preview {
    CouponDetailView(viewModel: CouponDetailViewModel(selectedCoupon: .stub01))
        .environmentObject(BDNavigationPathManager())
}
