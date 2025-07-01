//
//  PhotoZoomView.swift
//  BirtherDay
//
//  Created by Rama on 6/30/25.
//

import SwiftUI
import PhotosUI

import Kingfisher

struct PhotoZoomView<ImageType>: View {
    let images: [ImageType]
    let initialIndex: Int
    
    @Binding var isPresented: Bool
    @State private var currentIndex: Int
    
    init(
        images: [ImageType],
        initialIndex: Int,
        isPresented: Binding<Bool>
    ) {
        self.images = images
        self.initialIndex = initialIndex
        self._isPresented = isPresented
        self._currentIndex = State(initialValue: initialIndex)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            TabView(selection: $currentIndex) {
                ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                    zoomableImageView(image)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                currentIndex = initialIndex
            }
            
            VStack {
                headerView
                    .padding(.top, 16)
                Spacer()
            }
        }
    }
    
    private var headerView: some View {
        ZStack {
            Capsule()
                .frame(width: 55, height: 27)
                .foregroundStyle(Color.gray400)
                .overlay(
                    Text("\(currentIndex + 1) / \(images.count)")
                        .foregroundColor(.white)
                        .font(.r2)
                )
            
            HStack {
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .foregroundStyle(Color.gray300)
                }
            }
            .padding(.trailing, 16)
        }
    }

    
    @ViewBuilder
    private func zoomableImageView(_ image: ImageType) -> some View {
        GeometryReader { geometry in
            Group {
                // 타입에 따라 다른 뷰 렌더링
                if let uiImage = image as? UIImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if let kfImage = image as? KFImage {
                    kfImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }else {
                    Rectangle()
                        .fill(Color.gray)
                        .overlay(
                            Text("이미지를 불러올 수 없습니다")
                                .foregroundColor(.white)
                        )
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .clipped()
    }
}
