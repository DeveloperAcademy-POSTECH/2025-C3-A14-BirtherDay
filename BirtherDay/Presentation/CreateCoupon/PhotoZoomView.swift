//
//  PhotoZoomView.swift
//  BirtherDay
//
//  Created by Rama on 6/30/25.
//

import SwiftUI
import PhotosUI

struct PhotoZoomView: View {
    let image: UIImage
    let images: [UIImage]
    let initialIndex: Int
    
    @Binding var isPresented: Bool
    @State private var currentIndex: Int
    
    init(image: UIImage, images: [UIImage], initialIndex: Int, isPresented: Binding<Bool>) {
        self.image = image
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
                ForEach(Array(images.enumerated()), id: \.offset) { index, img in
                    zoomableImageView(img)
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
    
    private func zoomableImageView(_ image: UIImage) -> some View {
        GeometryReader { geometry in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .clipped()
    }
}
