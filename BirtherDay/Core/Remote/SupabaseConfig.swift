//
//  SupabaseConfig.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 5/29/25.
//
import Foundation

enum SupabaseConfig {
    static let url: URL = {
        guard let domain = Bundle.main.infoDictionary?["SUPABASE_DOMAIN"] as? String else {
            fatalError("Invalid SUPABASE_DOMAIN")
        }
        
        let url = "https://" + domain;
        
        return URL(string: url)!
    }()
    
    static let anonKey: String = {
        guard let key = Bundle.main.infoDictionary?["SUPABASE_KEY"] as? String else {
            fatalError("Invalid SUPABASE_KEY")
        }
        
        return key;
    }()
    
    static let captchaToken: String = {
        guard let captchaToken = Bundle.main.infoDictionary?["SUPABASE_CAPTCHA"] as? String else {
            fatalError("Invalid SUPABASE_CAPTCHA")
        }
        
        return captchaToken
    }()
}
