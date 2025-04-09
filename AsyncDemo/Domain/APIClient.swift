//
//  APIClient.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import Foundation

// MARK: - Protocol

protocol APIClientProtocol: Actor {
    func fetchRandomNumber() async throws -> Int
}

// MARK: - Implement

final actor APIClient: APIClientProtocol {
    
    static let shared: APIClient = .init()
    
    func fetchRandomNumber() async throws -> Int {
        try await Task.sleep(for: .seconds(1)) // Heavy Task
        return Int.random(in: 1...100)
    }
}

// MARK: - Stub

final actor APIClientStubWithTaskYield: APIClientProtocol {
    
    var randomNumber: Int = .zero // テスト側から返り値を指定できるようにする
    
    func setRandomNumber(_ randomNumber: Int) {
        self.randomNumber = randomNumber
    }
    
    func fetchRandomNumber() async throws -> Int {
        await Task.yield()
        return randomNumber
    }
}

final actor APIClientStubWithCheckedContinuation: APIClientProtocol {
    
    var fetchRandomNumberContinuation: CheckedContinuation<Int, Error>?
    
    func setFetchRandomNumberContinuation(_ fetchRandomNumberContinuation: CheckedContinuation<Int, Error>?) {
        self.fetchRandomNumberContinuation = fetchRandomNumberContinuation
    }
            
    func fetchRandomNumber() async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            fetchRandomNumberContinuation = continuation
        }
    }
}

