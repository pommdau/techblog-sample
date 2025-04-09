//
//  FirstViewStateTests.swift
//  AsyncDemoTests
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import XCTest
@testable import AsyncDemo
import ConcurrencyExtras

@MainActor
final class FirstViewStateTests: XCTestCase {
    
    // MARK: - Properties
        
    private var sut: FirstViewState!

    // MARK: - Setup/TearDown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - FetchRandomNumber Tests
    
    func testFetchRandomNumberButtonWithCheckedContinuation() async throws {
        func test() async throws {
            // MARK: Given
            let testNumber = Int.random(in: 0...10000)
            let apiClientStub = APIClientStubWithCheckedContinuation()
            sut = FirstViewState(apiClient: apiClientStub)
            XCTAssertNil(sut.number)
            
            // MARK: When
            // awaitの処理の完了を待たない(処理自体は並行して走っている)
            async let fetchRandomNumber: Void = sut.fetchRandomNumberButtonTapped()
            
            // MARK: Then
            
            // nilのチェックにより、try await apiClient.fetchRandomNumber()の中に入るまでタイミングを遅らせる
            while await apiClientStub.fetchRandomNumberContinuation == nil {
                await Task.yield()
            }
            XCTAssertTrue(sut.isConnecting) // 通信中フラグの確認
            
            // APIの実行
            // continuationにより任意のタイミングで発火させられる
            await apiClientStub.fetchRandomNumberContinuation?.resume(returning: testNumber)
            await apiClientStub.setFetchRandomNumberContinuation(nil)
            try await fetchRandomNumber // awaitの処理の完了を待つ(= try await apiClient.fetchRandomNumber())
                        
            // 操作完了後の状態確認
            XCTAssertFalse(sut.isConnecting)
            XCTAssertEqual(sut.number, testNumber)
        }
        
        // 非同期処理周りは一回だけだとうまく動作してしまってエラーを検出しきれないことがあるため、複数回テストを回す
        for _ in 0..<1000 {
            try await test()
        }
    }

    func testFetchRandomNumberButtonTappedWithTaskYield() async throws {
        
        func test() async throws {
            try await withMainSerialExecutor {
                // MARK: Given
                let testNumber = Int.random(in: 0...10000)
                let apiClientStub = APIClientStubWithTaskYield()
                await apiClientStub.setRandomNumber(testNumber)
                sut = FirstViewState(apiClient: apiClientStub)
                XCTAssertNil(sut.number)
                
                // MARK: When
                // ここは最終的に上述のテストのasync letとやっていることは同じことのはず(async letでも動作することは確認済み)
                let task = Task {
                    try await sut.fetchRandomNumberButtonTapped()
                }
                // MARK: Then
                await Task.yield() // fetchRandomNumber()内のTask.yield()の直前までタイミングをずらす
                XCTAssertTrue(sut.isConnecting)
                _ = try await task.value // 処理の完了を待つ
                
                // 操作完了後の状態確認
                XCTAssertFalse(sut.isConnecting)
                XCTAssertEqual(sut.number, testNumber)
            }
        }
        
        for _ in 0..<1000 {
            try await test()
            
        }
    }
}
