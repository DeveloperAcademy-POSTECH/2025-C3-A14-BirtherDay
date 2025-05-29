//
//  SupabaseManager.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 5/29/25.
//

import Foundation
import Supabase

final class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        client = SupabaseClient(
            supabaseURL: SupabaseConfig.url
            , supabaseKey: SupabaseConfig.anonKey
        )
    }
}
