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

/// CheckedContnuationをつかったStub
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

/// Task.yield()をつかったStub
final actor APIClientStubWithTaskYield: APIClientProtocol {
    
    var randomNumber: Int = .zero
    
    // テスト側から返り値を指定できるようにする
    func setRandomNumber(_ randomNumber: Int) {
        self.randomNumber = randomNumber
    }
    
    func fetchRandomNumber() async throws -> Int {
        await Task.yield() // 実行を1サイクル遅らせる
        
        // タスクがキャンセルされている場合は例外を投げる
        // Task.sleepやURLSessionの通信はキャンセル処理(CancellationErrorを投げる)が実装されていると思われるので、その代替の処理としてキャンセルチェックが必要
        if Task.isCancelled {
            throw CancellationError()
        }
        
        return randomNumber
    }
}
