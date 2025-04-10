//
//  SecondView.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import SwiftUI

// MARK: - ViewState

@MainActor
@Observable
final class SecondViewState {
    
    // MARK: - Property
    
    private let apiClient: APIClientProtocol
    private(set) var number: Int?
    private(set) var fetchRandomNumberTask: Task<(), Error>?
    private(set) var isProcessing = false
    private(set) var error: Error?
    
    var numberLabel: String {
        guard let number else {
            return "Not fetched yet"
        }
        return "\(number)"
    }
    
    // MARK: - LifeCycle
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Actions
    
    /// ランダムな番号を取得するボタンが押された
    func fetchRandomNumberButtonTapped() {
        isProcessing = true
        error = nil
        fetchRandomNumberTask = Task {
            defer {
                isProcessing = false
            }
            do {
                number = try await apiClient.fetchRandomNumber()
            } catch {
                if Task.isCancelled {
                    number = nil
                    self.error = MessageError(description: error.localizedDescription)
                } else {
                    fatalError("unimplemented")
                }
            }
        }
    }
    
    /// キャンセルボタンが押された
    func handleCancelButtonTapped() {
        fetchRandomNumberTask?.cancel()
        fetchRandomNumberTask = nil
    }
}

// MARK: - View

struct SecondView: View {
    
    @State private var state: SecondViewState = .init()
    
    var body: some View {
        Form {
            LabeledContent("Number", value: "\(state.numberLabel)")
            LabeledContent("Error", value: "\(state.error?.localizedDescription ?? "(no error)")")
            ZStack {
                if state.isProcessing {
                    HStack {
                        ProgressView()
                        Button("Cancel") {
                            state.handleCancelButtonTapped()
                        }
                    }
                } else {
                    Button("Fetch Ramdom Number") {
                        state.fetchRandomNumberButtonTapped()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    SecondView()
}
