//
//  APIClient.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import Foundation

protocol APIClientProtocol: Actor {
    func fetchRandomNumber() async throws -> Int
}

final actor APIClient: APIClientProtocol {
    
    static let shared: APIClient = .init()
    
    func fetchRandomNumber() async throws -> Int {
        try await Task.sleep(for: .seconds(1)) // Heavy Task
//        await Task.yield()
//        try await Task.sleep(for: .seconds(1))
        return Int.random(in: 1...100)
    }
}

final actor APIClientMock1: APIClientProtocol {
    
    var randomNumber: Int = .zero // テスト側から返り値を指定できるようにする
    
    func setRandomNumber(_ randomNumber: Int) {
        self.randomNumber = randomNumber
    }
    
    func fetchRandomNumber() async throws -> Int {
        await Task.yield()
        return randomNumber
    }
}

final actor APIClientMock2: APIClientProtocol {
    
    var randomNumber: Int = .zero // テスト側から返り値を指定できるようにする
    
    func fetchRandomNumber() async throws -> Int {
        try await Task.sleep(for: .nanoseconds(1))
        return randomNumber
    }
}
