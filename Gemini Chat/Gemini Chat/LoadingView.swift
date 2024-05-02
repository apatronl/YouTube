//
//  LoadingView.swift
//  Gemini Chat
//
//  Created by Ale Patrón on 4/22/24.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        Image(systemName: "ellipsis.rectangle.fill")
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(Color.gray)
            .font(.largeTitle)
            .symbolEffect(.variableColor, options: .repeating, isActive: true)
    }
}
