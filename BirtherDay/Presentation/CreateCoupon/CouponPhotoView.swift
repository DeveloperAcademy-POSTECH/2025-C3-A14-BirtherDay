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
            
            if viewModel.selectedImages.isEmpty {
                photoPickerView()
            } else {
                photoCarouselView()
            }
            
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
    
    func photoCarouselView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(Array(viewModel.selectedImages.enumerated()), id: \.element) { index, image in
                    selectedImageView(index: index, image: image)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func selectedImageView(index: Int, image: UIImage) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .cornerRadius(10)

            Button(action: {
                viewModel.deletePhoto(index: index)
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            }
            .offset(x: -5, y: 5)
        }
    }
}
#Preview {
    CouponPhotoView(viewModel: CreateCouponViewModel())
}
