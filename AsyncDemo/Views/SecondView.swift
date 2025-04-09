//
//  SecondView.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import SwiftUI

//
//  FirstView.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import SwiftUI

@MainActor
@Observable
final class SecondViewState {
    
    let apiClient: APIClientProtocol
    private(set) var fetchRandomNumberTask: Task<(), Error>?
    private(set) var number: Int?
    private(set) var isConnecting: Bool = false
    private(set) var error: Error?
    
    var numberLabel: String {
        guard let number else {
            return "Not fetched yet"
        }
        return "\(number)"
    }
    
    func fetchRandomNumberButtonTapped() async throws {
        error = nil
        isConnecting = true
        fetchRandomNumberTask = Task {
            defer {
                isConnecting = false
            }
            do {
                number = try await apiClient.fetchRandomNumber()
            } catch {
                if Task.isCancelled {
                    number = nil
                    self.error = MessageError(description: error.localizedDescription)
                } else {
                    number = nil
                    self.error = MessageError(description: error.localizedDescription)
                }
            }
        }
    }
    
    func handleCancelButtonTapped() {
        fetchRandomNumberTask?.cancel()
        fetchRandomNumberTask = nil
    }
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
}

struct SecondView: View {
    
    @State private var state: SecondViewState = .init()
    
    var body: some View {
        Form {
            LabeledContent("Number", value: "\(state.numberLabel)")
            LabeledContent("Error", value: "\(state.error?.localizedDescription ?? "(no error)")")
            ZStack {
                if state.isConnecting {
                    HStack {
                        ProgressView()
                        Button("Cancel") {
                            state.handleCancelButtonTapped()
                        }
                    }
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
    SecondView()
}
