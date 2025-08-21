//
//  View.swift
//  NYTimesApp
//
//  Created by Murtaza on 20/08/2025.
//

import SwiftUI

extension View {
    func loader(_ when: Bool, message: String = "") -> some View {
        ZStack {
            self
                .opacity(when ? 0.4 : 1)
                .disabled(when)
            
            ProgressView(message)
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1)
                .padding()
                .background(Color.gray)
                .cornerRadius(5)
                .foregroundColor(.white)
                .opacity(when ? 1 : 0)
                .frame(width: 250)
        }
    }
}
