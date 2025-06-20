//
//  CouponPhotoView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import PhotosUI
import SwiftUI

struct CouponPhotoView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    @ObservedObject var viewModel: CreateCouponViewModel
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    @State private var uploadedImagePaths: [String] = []
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            photoTitleView()
                .padding(.top, 12)
            
            Spacer()
            
            if selectedImages.isEmpty {
                photoPickerView()
                    .padding(.horizontal, 37)
            } else {
                photoCarouselView()
            }
            
            Spacer()
            
            if isLoading {
                ProgressView()
                    .padding(.bottom, 24)
            } else {
                nextButtonView()
                    .padding(.bottom, 20)
                    .padding(.horizontal, 16)
            }
        }
        .onAppear {
            loadExistingPhotos()
        }
        .background(Color.mainViolet50)
        .keyboardAware()
        .bdNavigationBar(
            title: "사진 첨부하기",
            backButtonAction: navPathManager.popPath
        )
    }
    
    func photoTitleView() -> some View {
        Text("함께 추억할 사진이 있다면\n첨부해주세요")
            .font(.sb4)
            .foregroundStyle(Color.textTitle)
            .multilineTextAlignment(.center)
    }
    
    func photoPickerView() -> some View {
        PhotosPicker(selection: $selectedItems,
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
                    
                    Text("여기를 눌러\n사진을 선택하세요")
                        .font(.sb2)
                        .foregroundStyle(Color.textCaption1)
                        .multilineTextAlignment(.center)
                }
            }
            .onChange(of: selectedItems) { oldValue, newValue in
                Task {
                    selectedImages = []
                    
                    for item in newValue {
                        do {
                            if let data = try await item.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                selectedImages.append(uiImage)
                            }
                        } catch {
                            print("이미지 디코딩 실패: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
    
    func photoCarouselView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(Array(selectedImages.enumerated()), id: \.element) { index, image in
                    selectedImageView(index: index, image: image)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 40)
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    func selectedImageView(index: Int, image: UIImage) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipped()
                .cornerRadius(10)
            
            Button {
                deletePhoto(at: index)
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.5))
                    .clipShape(Circle())
            }
            .offset(x: -10, y: 10)
        }
    }
    
    func nextButtonView() -> some View {
        Button(
            action: {
                Task {
                    isLoading = true
                    let uploadedPaths = await viewModel.uploadImages(selectedImages)
                    uploadedImagePaths = uploadedPaths
                    viewModel.update(
                        .photos(
                            images: selectedImages,
                            paths: uploadedImagePaths
                        )
                    )
                    await viewModel.uploadCoupon()
                    isLoading = false
                    navPathManager.pushCreatePath(.couponComplete)
                }
            }) {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
            }
            .buttonStyle(BDButtonStyle(buttonType: .activate))
    }
}

extension CouponPhotoView {
    private func loadExistingPhotos() {
        if !viewModel.couponData.selectedImages.isEmpty {
            selectedItems = viewModel.couponData.selectedItems
            selectedImages = viewModel.couponData.selectedImages
        }
    }
    
    private func deletePhoto(at index: Int) {
        selectedImages.remove(at: index)
        
        // 모든 이미지가 삭제되면 선택 상태도 초기화
        if selectedImages.isEmpty {
            selectedItems = []
        }
    }
}

#Preview {
    CouponPhotoView(viewModel: CreateCouponViewModel())
}
