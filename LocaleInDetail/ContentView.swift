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
    let autoUpdatingLocale = Locale.autoupdatingCurrent
    let currentCalendar = Calendar.current
    let autoUpdatingCalendar = Calendar.autoupdatingCurrent
    
    struct LogEntry: Identifiable {
        let id = UUID()
        let message: String
        let type: ButtonType
        var color: Color { type.color }
    }

    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                alignment: .center,
                spacing: 20
            ) {
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
                        Text(NSLocalizedString("console", bundle: "ja".bundle, comment: ""))
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
                                .font(.footnote)
                                .fontWeight(.medium)
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
                    maxWidth: .infinity,
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
            value = autoUpdatingLocale.identifier
        case .currentCalendar:
            value = currentCalendar
        case .autoUpdateCalendar:
            value = autoUpdatingCalendar
        case .preferredLang:
            value = Locale.preferredLanguages.joined(separator: ", ")
        case .preferredLocalizations:
            value = Bundle.main.preferredLocalizations.joined(separator: ", ")
        }
        logs.append(LogEntry(message: "\(type.description): \n\(value)", type: type))
    }
    
    private func makeButton(for type: ButtonType) -> some View {
        Button(action: {
            self.log(type)
        }) {
            Text(type.varName)
                .font(.body)
                .fontWeight(.semibold)
                .fontWidth(Font.Width.condensed)
                .minimumScaleFactor(0.75)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
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

