//
//  AuthService.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 5/29/25.
//

import Foundation
import Supabase

final class AuthService {
    private let client = SupabaseManager.shared.client
    
    /// 익명 로그인(Sign In Anonymously)을 수행하고 Supabase 세션을 반환합니다.
    ///  SDK 자체적으로 access token과 refresh token을 자동으로 관리해주기에, 별도의 처리가 필요하지 않습니다.
    /// - Returns: `Session` 객체 (`accessToken`, `refreshToken`, `user.id` 포함)
    /// - Throws: 인증 실패 또는 네트워크 오류 발생 시 예외를 던짐
    ///
    /// 반환 예시:
    /// ```
    /// Session(
    ///   accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    ///   refreshToken: "b5dxvz6vp5tk",
    ///   user: Auth.User(id: 154DEA32-8607-4418-A619-D80692456678, ...)
    ///   ...
    /// )
    /// ```
    func signUp() async throws -> Session {
        let session = try await client.auth.signInAnonymously()
        
        return session
    }
}
