//
//  ContentView.swift
//  LocaleInDetail
//
//  Created by Daniel Hu on 2023/09/04.
//

import SwiftUI

struct ContentView: View {
    @State private var logs: [LogEntry] = []

    let currentLocale = Locale.current
    let autoUpdateLocale = Locale.autoupdatingCurrent
    let currentCalendar = Calendar.current
    let autoUpdateCalendar = Calendar.autoupdatingCurrent
    
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
    
    struct LogEntry: Identifiable {
        let id = UUID()
        let message: String
        let type: ButtonType
        var color: Color { type.color }
    }

    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                makeButton(for: .currentLocale)
                makeButton(for: .autoUpdateLocale)
                
                makeButton(for: .currentCalendar)
                makeButton(for: .autoUpdateCalendar)
                
                makeButton(for: .preferredLang)
                makeButton(for: .preferredLocalizations)
            }

            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(NSLocalizedString("console", comment: ""))
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            self.logs.removeAll()
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                    ScrollView {
                        ForEach(logs) { log in
                            Text(log.message)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)
                                .foregroundColor(log.color)
                                .padding(.bottom, 2)
                                .frame(width: geo.size.width, alignment: .leading)
                        }
                    }
                    .frame(width: geo.size.width)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .padding(.top, 20)
            }
            
        }
        .padding()
    }

    private func log(_ type: ButtonType) {
        let value: Any
        switch type {
        case .currentLocale:
            value = currentLocale.identifier
        case .autoUpdateLocale:
            value = autoUpdateLocale.identifier
        case .currentCalendar:
            value = currentCalendar
        case .autoUpdateCalendar:
            value = autoUpdateCalendar
        case .preferredLang:
            value = Locale.preferredLanguages.joined(separator: ", ")
        case .preferredLocalizations:
            value = Bundle.main.preferredLocalizations.joined(separator: ", ")
        }
        logs.append(LogEntry(message: "\(type.description): \(value)", type: type))
    }
    
    private func makeButton(for type: ButtonType) -> some View {
        Button(action: {
            self.log(type)
        }) {
            Text(type.varName)
                .bold()
                .fontWidth(Font.Width.condensed)
                .minimumScaleFactor(0.75)
                .lineLimit(2)
                .padding()
                .background(type.color)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

