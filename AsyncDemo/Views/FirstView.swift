//
//  FirstView.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import SwiftUI

@MainActor
@Observable
final class FirstViewState {
    
    let apiClient: APIClientProtocol
    private(set) var number: Int?
    private(set) var isConnecting: Bool = false
    
    var numberLabel: String {
        guard let number else {
            return "Not fetched yet"
        }
        return "\(number)"
    }
    
    func fetchRandomNumberButtonTapped() async throws {
        try await Task.sleep(for: .seconds(1))
        isConnecting = true
        print("isConnecting = true")
        defer {
            isConnecting = false
        }
        number = try await apiClient.fetchRandomNumber()
    }
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
}

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
