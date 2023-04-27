//
//  ContentView.swift
//  Copify
//
//  Created by Collin Struthers on 2023-04-26.
//

import SwiftUI

struct ContentView: View {
    @State private var clipboardArray = [String]() // Declare the clipboard array

    var body: some View {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(clipboardArray, id: \.self) { clipboardItem in
                        Text(clipboardItem)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .onHover { isHovered in
                                                        if isHovered {
                                                            NSCursor.pointingHand.push()
                                                        } else {
                                                            NSCursor.pop()
                                                        }
                                                    }
                           
                            
                    }
                }
                .padding(20)
            }.onAppear {
                let pasteboard = NSPasteboard.general
                var changeCount = pasteboard.changeCount
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                    if pasteboard.changeCount != changeCount {
                        changeCount = pasteboard.changeCount
                        if let clipboardData = pasteboard.string(forType: .string) {
                            let newClipboardItems = [clipboardData]
                            //
                            //  if let newClipboardData = pasteboard.string(forType: .string) {
                            //                            clipboardData = newClipboardData
                            //                        }
                            //
                            clipboardArray.append(contentsOf: newClipboardItems)
                            while clipboardArray.count > 10 {
                                clipboardArray.removeFirst()
                            }
                        }
                        }
                    }
                }
            }
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
