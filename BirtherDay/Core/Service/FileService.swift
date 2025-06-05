//
//  FileService.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 6/2/25.
//

import Foundation
import Storage

enum ImageDirectory: String {
    case couponDetail = "couponDetail"
    case couponThumbnail = "couponThumbnail"
}

final class FileService {
    private let client = SupabaseManager.shared.client;
    
    /// Supabase Storage에 이미지를 업로드합니다.
    ///
    /// - Parameters:
    ///   - data: 업로드할 이미지의 바이너리 데이터 (`Data`)
    ///   - directory: 저장할 디렉토리 (예: `.couponDetail`, `.couponThumbnail`)
    ///
    /// - Returns: 업로드된 파일의 전체 경로 (`fullPath`) 문자열
    ///
    /// - Throws: 업로드 실패 또는 네트워크 오류 발생 시 예외를 던집니다.
    func uploadImage(_ data: Data, to directory: ImageDirectory) async throws -> String {
        let fileName = UUID().uuidString
        let filePath = "\(directory.rawValue)/\(fileName)"
        
        let res = try await client.storage.from("coupon").upload(filePath, data: data, options: FileOptions(
            contentType: "image/*",
            upsert: false
          ))
        
        let fullPath = "\(SupabaseConfig.url)\(SupabaseConfig.storagePath)\(res.fullPath)"
        
        return fullPath
    }
}
