//
//  CouponPhotoView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import PhotosUI
import SwiftUI

struct CouponPhotoView: View {
    @ObservedObject var viewModel: CreateCouponViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            photoTitleView()
            
            Spacer()
                .frame(height: 88)
            
            photoPickerView()
            
            Spacer()
            
            Text("확인") //TODO: 컴포넌트 분리되면 버튼 추가
        }
        .padding(.top, 12)
        .padding(.bottom, 20)
    }
    
    func photoTitleView() -> some View{
        Text("함께 추억할 사진이 있다면\n첨부해주세요")
            .font(.sb4)
            .foregroundStyle(Color.textTitle)
            .multilineTextAlignment(.center)
    }
    
    func photoPickerView() -> some View {
        PhotosPicker(selection: $viewModel.selectedItems,
                     maxSelectionCount: 5,
                     matching: .images) {
            ZStack {
                Rectangle()
                    .frame(width: 300, height: 300)
                    .foregroundStyle(Color.gray200)
                    .cornerRadius(17.45)
                
                VStack(spacing: 4) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(
                            width: 19,
                            height: 19
                        )
                        .foregroundStyle(Color.textCaption1)
                    
                    Text("여기를 눌러\n사진을 선택하세요") //TODO: LineHeight 설정
                        .font(.sb2)
                        .foregroundStyle(Color.textCaption1)
                        .multilineTextAlignment(.center)
                }
            }
            .onChange(of: viewModel.selectedItems) { oldValue, newValue in
                viewModel.convertItems(oldItems: oldValue, newItems: newValue)
            }
        }
    }
}

#Preview {
    CouponPhotoView(viewModel: CreateCouponViewModel())
}
