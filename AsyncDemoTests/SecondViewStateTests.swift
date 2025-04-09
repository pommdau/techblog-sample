//
//  SecondViewStateTests.swift
//  AsyncDemoTests
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import XCTest
@testable import AsyncDemo
import ConcurrencyExtras

@MainActor
final class SecondViewStateTests: XCTestCase {
    
    // MARK: - Properties
        
    private var sut: SecondViewState!

    // MARK: - Setup/TearDown
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: - 数字の取得のテスト
    
    func testFetchRandomNumberButtonTappedWithContinuation() async throws {
        
        func test() async throws {
            
            // MARK: Given
            let testNumber = Int.random(in: 0...10000)
            let apiClientMock = APIClientStubWithCheckedContinuation()
            sut = SecondViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            sut.fetchRandomNumberButtonTapped() // awaitメソッドではなくTaskのプロパティを持って管理している
            
            // MARK: Then
            while await apiClientMock.fetchRandomNumberContinuation == nil {
                await Task.yield()
            }
            XCTAssertTrue(sut.isConnecting)
            
            // APIの実行
            await apiClientMock.fetchRandomNumberContinuation?.resume(returning: testNumber)
            await apiClientMock.setFetchRandomNumberContinuation(nil)
            try await sut.fetchRandomNumberTask?.value // Taskの完了まで待つ
            
            // 操作完了後の状態確認
            XCTAssertFalse(sut.isConnecting)
            XCTAssertEqual(sut.number, testNumber)
        }
        
        for _ in 0..<1000 {
            try await withMainSerialExecutor {
                try await test()
            }
        }
    }
    
    func testFetchRandomNumberButtonTappedWithMainSerialExecutor() async throws {
        
        func test() async throws {
            // MARK: Given
            let testNumber = Int.random(in: 0...100)
            let apiClientMock = APIClientStubWithTaskYield()
            await apiClientMock.setRandomNumber(testNumber)
            sut = SecondViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            sut.fetchRandomNumberButtonTapped()
            
            // MARK: Then
//            await Task.yield()
            XCTAssertTrue(sut.isConnecting)
            try await sut.fetchRandomNumberTask?.value
            
            // 操作完了後の状態確認
            XCTAssertFalse(sut.isConnecting)
            XCTAssertEqual(sut.number, testNumber)
        }
        
        for _ in 0..<1000 {
            try await withMainSerialExecutor {
                try await test()
            }
        }
    }
    
    
    
    // MARK: - 数字の取得+キャンセルのテスト
        
    /// 数字の取得とキャンセルのテスト+continuation
    func testFetchAndCancelWithContinuation() async throws {
        
        func test() async throws {
            // MARK: Given
            let apiClientMock = APIClientStubWithCheckedContinuation()
            sut = SecondViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            sut.fetchRandomNumberButtonTapped()
            while await apiClientMock.fetchRandomNumberContinuation == nil {
                await Task.yield()
            }
            
            // MARK: Then
            XCTAssertTrue(sut.isConnecting)
            
            // sut側のfetchRandomNumberTaskはキャンセル後にnilになってしまいテストできなくなるため、テスト側で参照を保持させる
            let fetchRandomNumberTask = sut.fetchRandomNumberTask
            
            sut.handleCancelButtonTapped()
            await apiClientMock.fetchRandomNumberContinuation?.resume(throwing: CancellationError())
            await apiClientMock.setFetchRandomNumberContinuation(nil)
            _ = await fetchRandomNumberTask?.result // キャンセル時の処理が完了するまで待つ
            
            XCTAssertFalse(sut.isConnecting)
            XCTAssertNil(sut.number)
            XCTAssertNotNil(sut.error)
        }
        
        for _ in 0..<100 {
            try await test()
        }
    }
    
    /// 数字の取得とキャンセルのテスト+WithMainSerialExecutor
    func testFetchAndCancelWithMainSerialExecutor() async throws {
        
        func test() async throws {
            // MARK: Given
            let testNumber = Int.random(in: 0...100)
            let apiClientMock = APIClientStubWithTaskYield()
            await apiClientMock.setRandomNumber(testNumber)
            sut = SecondViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            sut.fetchRandomNumberButtonTapped()
            
            // MARK: Then
            XCTAssertTrue(sut.isConnecting)
            
            let fetchRandomNumberTask = sut.fetchRandomNumberTask // sut側のfetchRandomNumberTaskはキャンセル後にnilになってしまいテストできなくなるため、テスト側で参照を保持させる
            sut.handleCancelButtonTapped()
            _ = await fetchRandomNumberTask?.result
            
            // 操作完了後の状態確認
            XCTAssertFalse(sut.isConnecting)
            XCTAssertNil(sut.number)
            XCTAssertNotNil(sut.error)
        }
        
        for _ in 0..<1000 {
            try await withMainSerialExecutor {
                try await test()
            }
        }
    }
}
