//
//  Localize.swift
//  Notefy
//
//  Created by Talip Göksu on 21.04.18.
//  Copyright © 2018 Iman Studios. All rights reserved.
//

import Foundation

let currentLanguageKey = "CurrentLanguageKey"
let defaultLanguageStatic = "en"
let baseBundle = "Base"

public let languageChangeNotification = "LanguageChangeNotification"

public func localized(_ string: String) -> String {
    return string.localized()
}

public func localized(_ string: String, arguments: CVarArg...) -> String {
    return String(format: string.localized(), arguments: arguments)
}

public func localizedPlural(_ string: String, argument: CVarArg) -> String {
    return string.localizedPlural(argument)
}

public extension String {
    func localized(in bundle: Bundle?) -> String {
        return localized(using: nil, in: bundle)
    }
    
    func localizedFormat(arguments: CVarArg..., in bundle: Bundle?) -> String {
        return String(format: localized(in: bundle), arguments: arguments)
    }
    
    func localizedPlural(argument: CVarArg, in bundle: Bundle?) -> String {
        return NSString.localizedStringWithFormat(localized(in: bundle) as NSString, argument) as String
    }
    
    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let type = "lproj"
        let bundle: Bundle = bundle ?? .main
        if let path = bundle.path(forResource: Localize.currentLanguage, ofType: type),
            let bundle = Bundle(path: path) {
            let content = bundle.localizedString(forKey: self, value: nil, table: tableName)
            if content == self {
                warnInvalidLocalizableKey()
            }
            return content
        } else if let path = bundle.path(forResource: baseBundle, ofType: type),
            let bundle = Bundle(path: path) {
            let content = bundle.localizedString(forKey: self, value: nil, table: tableName)
            if content == self {
                warnInvalidLocalizableKey()
            }
            return content
        }
        return self
    }
    
    private func warnInvalidLocalizableKey() {
        //print("Hey, idiot! ◀️\(self.uppercased())▶️ is not a fucking valid localizable key")
    }
    
    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized(using: tableName, in: bundle), arguments: arguments)
    }
    
    func localizedPlural(argument: CVarArg, using tableName: String?, in bundle: Bundle?) -> String {
        return NSString.localizedStringWithFormat(localized(using: tableName, in: bundle) as NSString, argument) as String
    }
    
    func localized(using tableName: String?) -> String {
        return localized(using: tableName, in: .main)
    }
    
    func localizedFormat(arguments: CVarArg..., using tableName: String?) -> String {
        return String(format: localized(using: tableName), arguments: arguments)
    }
    
    func localizedPlural(argument: CVarArg, using tableName: String?) -> String {
        return NSString.localizedStringWithFormat(localized(using: tableName) as NSString, argument) as String
    }
    
    func localized() -> String {
        return localized(using: nil, in: .main)
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
    
    func localizedPlural(_ argument: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized() as NSString, argument) as String
    }
}

open class Localize: NSObject {
    open static func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.index(of: baseBundle), excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    open static var currentLanguage: String {
        if let currentLanguage = UserDefaults.standard.object(forKey: currentLanguageKey) as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }
    
    open static func currentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if selectedLanguage != currentLanguage {
            UserDefaults.standard.set(selectedLanguage, forKey: currentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: languageChangeNotification), object: language)
        }
    }
    
    open static func defaultLanguage() -> String {
        var defaultLanguage = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return defaultLanguageStatic
        }
        let availableLanguages: [String] = self.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = defaultLanguageStatic
        }
        return defaultLanguage
    }
    
    open static func resetCurrentLanguageToDefault() {
        currentLanguage(self.defaultLanguage())
    }
    
    open static func displayNameForLanguage(_ language: String) -> String {
        let locale: NSLocale = NSLocale(localeIdentifier: currentLanguage)
        if let displayName = (locale as NSLocale).displayName(forKey: NSLocale.Key.languageCode, value: language) {
            return displayName
        }
        return String()
    }
}
