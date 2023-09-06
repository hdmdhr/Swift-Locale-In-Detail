//
//  Utils.swift
//  LocaleInDetail
//
//  Created by Daniel Hu on 2023/09/06.
//

import Foundation

typealias LanguageCode = String

extension LanguageCode {
    var bundle: Bundle {
        let path = Bundle.main.path(forResource: self, ofType: "lproj") ??
            Bundle.main.path(forResource: "Base", ofType: "lproj")

        return path.map { Bundle(path: $0) ?? .main } ?? .main
    }
}

extension Optional where Wrapped == LanguageCode {
    var bundle: Bundle { (self ?? "Base").bundle }
}
