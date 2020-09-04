//
//  LocalizationManager.swift
//  LocalizationManager
//
//  Created by Ahmed masoud on 8/10/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import UIKit

protocol LocalizationDelegate: class {
    func resetApp()
}

class LocalizationManager: NSObject {
    enum LanguageDirection {
        case leftToRight
        case rightToLeft
    }
    
    enum Language: String {
        case English = "en"
        case Arabic = "ar"
    }
    
    static let shared = LocalizationManager()
    private var bundle: Bundle? = nil
    private var languageKey = "UKPrefLang"
    weak var delegate: LocalizationDelegate?
    
    // get currently selected language from el user defaults
    func getLanguage() -> Language? {
        if let languageCode = UserDefaults.standard.string(forKey: languageKey), let language = Language(rawValue: languageCode) {
            return language
        }
        return nil
    }
    
    // check if the language is available
    private func isLanguageAvailable(_ code: String) -> Language? {
        var finalCode = ""
        if code.contains("ar") {
            finalCode = "ar"
        } else if code.contains("en") {
            finalCode = "en"
        }
        return Language(rawValue: finalCode)
    }
    
    // check the language direction
    private func getLanguageDirection() -> LanguageDirection {
        if let lang = getLanguage() {
            switch lang {
            case .English:
                return .leftToRight
            case .Arabic:
                return .rightToLeft
            }
        }
        return .leftToRight
    }
    
    // get localized string for a given code from the active bundle
    func localizedString(for key: String, value comment: String) -> String {
        let localized = bundle!.localizedString(forKey: key, value: comment, table: nil)
        return localized
    }
    
    // set language for localization
    func setLanguage(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: languageKey)
        if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj") {
            bundle = Bundle(path: path)
        } else {
            // fallback
            resetLocalization()
        }
        UserDefaults.standard.synchronize()
        resetApp()
    }
    
    // reset bundle
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    // reset app for the new language
    func resetApp() {
        let dir = getLanguageDirection()
        var semantic: UISemanticContentAttribute!
        switch dir {
        case .leftToRight:
            semantic = .forceLeftToRight
        case .rightToLeft:
            semantic = .forceRightToLeft
        }
        UITabBar.appearance().semanticContentAttribute = semantic
        UIView.appearance().semanticContentAttribute = semantic
        UINavigationBar.appearance().semanticContentAttribute = semantic
        delegate?.resetApp()
    }
    
    // configure startup language
    func setAppInnitLanguage() {
        if let selectedLanguage = getLanguage() {
            setLanguage(language: selectedLanguage)
        } else {
            // no language was selected
            let languageCode = Locale.preferredLanguages.first
            if let code = languageCode, let language = isLanguageAvailable(code) {
                setLanguage(language: language)
            } else {
                // default fall back
                setLanguage(language: .English)
            }
        }
        resetApp()
    }
}

extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(for: self, value: "")
    }
}
