//
//  ContentView.swift
//  LocaleInDetail
//
//  Created by Daniel Hu on 2023/09/04.
//

import SwiftUI

struct ContentView: View {
    @State private var consoleText: String = ""

    let labels = [
        "Locale.current",
        "Locale.autoUpdatingCurrent",
        "Locale.preferredLanguages",
        "Bundle.main.preferredLocalizations",
    ]
    let colors: [Color] = [
        .blue,
        .green,
        .orange,
        .purple
    ]

    var body: some View {
        VStack(spacing: 20) {
            // 2x2 Grid for buttons
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                Button(action: {
                    self.log(labels[0], Locale.current.identifier)
                }) {
                    Text(labels[0])
                        .padding()
                        .background(colors[0])
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    self.log(labels[1], Locale.autoupdatingCurrent.identifier)
                }) {
                    Text(labels[1])
                        .padding()
                        .background(colors[1])
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    self.log(labels[2], Locale.preferredLanguages.joined(separator: ", "))
                }) {
                    Text(labels[2])
                        .padding()
                        .background(colors[2])
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    self.log(labels[3], Bundle.main.preferredLocalizations.joined(separator: ", "))
                }) {
                    Text(labels[3])
                        .padding()
                        .background(colors[3])
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Console:")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            self.consoleText = ""
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                    ScrollView {
                        Text(consoleText)
                            .padding()
                            .frame(width: geo.size.width, height: .infinity)
                    }
                    .frame(width: geo.size.width, height: .infinity, alignment: .leading)
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

    func log(_ name: String, _ value: Any) {
        consoleText += "\(name): \(value)\n"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

