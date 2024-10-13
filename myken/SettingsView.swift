//
//  SettingsView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            Text("Settings View")
                .frame(maxHeight: .infinity)
        }
    }
}
#Preview {
    SettingsView()
}
