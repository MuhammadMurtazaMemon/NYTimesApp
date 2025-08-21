//
//  ErrorHandler.swift
//  NYTimesApp
//
//  Created by Murtaza on 20/08/2025.
//


import SwiftUI

protocol ErrorHandler {
    func showErrorMessage(_ message: String?, onDismiss: (() -> Void)?)
    func showErrorMessage(_ error: NetworkError)
}

class NetworkErrorHandler: ErrorHandler, ObservableObject {
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    var completion: (() -> Void)?
    
    func showErrorMessage(_ message: String?, onDismiss: (() -> Void)? = nil) {
        errorMessage = message ?? "An error occured. Please try again!"
        showAlert = true
        self.completion = onDismiss
    }
        
    func showErrorMessage(_ error: NetworkError) {
        switch error {
        case .ErrorMessage(let message):
            errorMessage = message
        case .ResponseDataIsNil:
            errorMessage = "Decoding Error"
        default:
            errorMessage = "An error occured. Please try again!"
        }
        showAlert = true
    }
    
}

struct ErrorHandlerModifier: ViewModifier {
    @StateObject var errorHandling: NetworkErrorHandler

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $errorHandling.showAlert) {
                Alert(title: Text("Error"), message: Text(errorHandling.errorMessage), dismissButton: .default(Text("OK"), action: errorHandling.completion ?? {}))
            }
    }
}

extension View {
    func withErrorHandling(errorHandling: NetworkErrorHandler) -> some View {
        modifier(ErrorHandlerModifier(errorHandling: errorHandling))
    }
}
