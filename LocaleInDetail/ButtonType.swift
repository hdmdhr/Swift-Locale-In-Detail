//
//  ButtonType.swift
//  LocaleInDetail
//
//  Created by Daniel Hu on 2023/09/04.
//

import Foundation
import SwiftUI

enum ButtonType: Int, CustomStringConvertible {
    case currentLocale
    case autoUpdateLocale
    case currentCalendar
    case autoUpdateCalendar
    case preferredLang
    case preferredLocalizations
    
    var varName: String {
        switch self {
        case .currentLocale:
            return "Locale.current"
        case .autoUpdateLocale:
            return "Locale.autoUpdatingCurrent"
        case .currentCalendar:
            return "Calendar.current"
        case .autoUpdateCalendar:
            return "Calendar.autoupdatingCurrent"
        case .preferredLang:
            return "Locale.preferredLanguages"
        case .preferredLocalizations:
            return "Bundle.main.preferredLocalizations"
        }
    }
    
    var description: String {
        switch self {
        case .currentLocale:
            return NSLocalizedString("current.locale", comment: "")
        case .autoUpdateLocale:
            return NSLocalizedString("autoupdate.locale", comment: "")
        case .currentCalendar:
            return NSLocalizedString("current.calendar", comment: "")
        case .autoUpdateCalendar:
            return NSLocalizedString("autoupdate.calendar", comment: "")
        case .preferredLang:
            return NSLocalizedString("preferred.languages", comment: "")
        case .preferredLocalizations:
            return NSLocalizedString("bundle.preferred.localizations", comment: "")
        }
    }
    
    var color: Color {
        switch self {
        case .currentLocale: return .blue
        case .autoUpdateLocale: return .green
        case .currentCalendar: return .indigo
        case .autoUpdateCalendar: return .mint
        case .preferredLang: return .orange
        case .preferredLocalizations: return .purple
        }
    }
}
