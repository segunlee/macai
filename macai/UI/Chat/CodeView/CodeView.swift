//
//  CodeView.swift
//  macai
//
//  Created by Renat on 07.06.2024.
//

import SwiftUI
import AttributedText
import Foundation
import Highlightr

struct CodeView: View {
    let code: String
    let lang: String
    var isStreaming: Bool
    @StateObject private var viewModel: CodeViewModel
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var previewStateManager: PreviewStateManager
    @State private var highlightedCode: NSAttributedString?
    
    init(code: String, lang: String, isStreaming: Bool = false) {
        self.code = code
        self.lang = lang
        self.isStreaming = isStreaming
        _viewModel = StateObject(wrappedValue: CodeViewModel(
            code: code,
            language: lang,
            isStreaming: isStreaming
        ))
    }
    
    var body: some View {
        VStack {
            headerView
            if let highlighted = highlightedCode {
                AttributedText(highlighted)
                    .textSelection(.enabled)
                    .padding([.horizontal, .bottom], 12)
            }
        }
        .background(codeBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .onChange(of: colorScheme) { newScheme in
            updateHighlightedCode(colorScheme: newScheme)
        }
        .onChange(of: code) { code in
            if isStreaming {
                print("Code changed: \(code)")
                updateHighlightedCode(colorScheme: colorScheme, code: code)
            }
        }
        .onAppear {
            updateHighlightedCode(colorScheme: colorScheme)
        }
    }
    
    private var headerView: some View {
        HStack {
            if lang != "" {
                Text(lang)
                    .fontWeight(.bold)
            }
            Spacer()
            
            HStack(spacing: 12) {
                if lang.lowercased() == "html" {
                    runButton
                }
                copyButton
            }
        }
        .padding(12)
        
        
    }
    
    private var copyButton: some View {
        Button(action: viewModel.copyToClipboard) {
            Image(systemName: viewModel.isCopied ? "checkmark" : "doc.on.doc")
                .frame(height: 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var runButton: some View {
        Button(action: togglePreview) {
            Image(systemName: previewStateManager.isPreviewVisible ? "play.slash" : "play")
                .frame(height: 12)
            
            Text("Run")
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func togglePreview() {
        if previewStateManager.isPreviewVisible {
            previewStateManager.hidePreview()
        } else {
            previewStateManager.showPreview(content: code)
        }
    }
    
    private var codeBackground: Color {
        colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.15) : Color(red: 0.96, green: 0.96, blue: 0.96)
    }

    
    private func updateHighlightedCode(colorScheme: ColorScheme, code: String = "") {
        DispatchQueue.main.async {
            if (code != "") {
                viewModel.code = code
            }
            viewModel.updateHighlighting(colorScheme: colorScheme)
            highlightedCode = viewModel.highlightedCode
        }
    }
}

#Preview {
    CodeView(code: "<h1>Hello World</h1>", lang: "html")
        .environmentObject(PreviewStateManager())
}
