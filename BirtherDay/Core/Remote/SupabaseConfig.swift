//
//  SupabaseConfig.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 5/29/25.
//
import Foundation

enum SupabaseConfig {
    static let url: URL = {
        guard let url = Bundle.main.infoDictionary?["SUPABSE_URL"] as? String else {
            fatalError("Invalid SUPABASE_URL")
        }
        
        return URL(string: url)!
    }()
    
    static let anonKey: String = {
        guard let key = Bundle.main.infoDictionary?["SUPABASE_KEY"] as? String else {
            fatalError("Invalid SUPABASE_KEY")
        }
        
        return key;
    }()
}
