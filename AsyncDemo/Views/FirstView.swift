//
//  FirstView.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import SwiftUI

// MARK: - ViewState

@MainActor
@Observable
final class FirstViewState {
    
    // MARK: - Property
    
    private let apiClient: APIClientProtocol
    private(set) var number: Int?
    private(set) var isConnecting = false // 通信中のフラグ
    
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
    
    func fetchRandomNumberButtonTapped() async throws {
        isConnecting = true
        defer {
            isConnecting = false
        }
        number = try await apiClient.fetchRandomNumber()
    }
}

// MARK: - View

struct FirstView: View {
    
    @State private var state: FirstViewState = .init()
    
    var body: some View {
        Form {
            LabeledContent("Number", value: "\(state.numberLabel)")
            ZStack {
                if state.isConnecting {
                    ProgressView()
                } else {
                    Button("Fetch Ramdom Number") {
                        Task {
                            do {
                                try await state.fetchRandomNumberButtonTapped()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    FirstView()
}
