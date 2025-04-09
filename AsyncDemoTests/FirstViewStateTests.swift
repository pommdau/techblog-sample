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
final class ViewModelTestTests: XCTestCase {
    
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

    func testFetchRandomNumberButtonTapped() async throws {
        
        func test() async throws {
            // MARK: Given
            let testNumber = 100
            let apiClientMock = APIClientMock1()
            await apiClientMock.setRandomNumber(testNumber)
            sut = FirstViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            let task = Task {
                try await sut.fetchRandomNumberButtonTapped()
            }
            
            // MARK: Then
            await Task.yield()
            XCTAssertTrue(sut.isConnecting)
            try await task.value
            XCTAssertFalse(sut.isConnecting)
            XCTAssertEqual(sut.number, testNumber)
        }
        
        for _ in 0..<1000 {
            try await withMainSerialExecutor {
                try await test()
            }
        }
    }
    
    func testFetchRandomNumberButtonTapped2() async throws {
        
        func test() async throws {
            
            // MARK: Given
            let testNumber = Int.random(in: 0...10000)
            let apiClientMock = APIClientMock2()
            sut = FirstViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            async let fetchRandomNumber: Void = sut.fetchRandomNumberButtonTapped()
            while await apiClientMock.fetchRandomNumberContinuation == nil {
                await Task.yield()
            }
            
            // MARK: Then
            XCTAssertTrue(sut.isConnecting)
            
            // APIの実行
            await apiClientMock.fetchRandomNumberContinuation?.resume(returning: testNumber)
            await apiClientMock.setFetchRandomNumberContinuation(nil)
            try await fetchRandomNumber
                        
            XCTAssertFalse(sut.isConnecting)
            XCTAssertEqual(sut.number, testNumber)
            print(testNumber)
        }
        
        for _ in 0..<1000 {
            try await test()
        }
    }
}
