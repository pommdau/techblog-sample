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
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchRandomNumberButtonTapped() async throws {
        
        func test() async throws {
            // MARK: Given
            let testNumber = Int.random(in: 0...100)
            let apiClientMock = APIClientMock1()
            await apiClientMock.setRandomNumber(testNumber)
            sut = SecondViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            sut.fetchRandomNumberButtonTapped()
            
            // MARK: Then
            await Task.yield()
            XCTAssertTrue(sut.isConnecting)
            try await sut.fetchRandomNumberTask?.value
            XCTAssertFalse(sut.isConnecting)
            XCTAssertEqual(sut.number, testNumber)
        }
        
        for _ in 0..<1000 {
            try await withMainSerialExecutor {
                try await test()
            }
        }
    }
    
//    func testFetchRandomNumberButtonTapped2() async throws {
//        
//        func test() async throws {
//            // MARK: Given
//            let testNumber = Int.random(in: 0...100)
//            let apiClientMock = APIClientMock2()
//            await apiClientMock.setRandomNumber(testNumber)
//            sut = SecondViewState(apiClient: apiClientMock)
//            XCTAssertNil(sut.number)
//            
//            // MARK: When
//            try await sut.fetchRandomNumberButtonTapped()
//            
//            // MARK: Then
//            await Task.yield()
//            XCTAssertTrue(sut.isConnecting)
//            try await sut.fetchRandomNumberTask?.value
//            XCTAssertFalse(sut.isConnecting)
//            XCTAssertEqual(sut.number, testNumber)
//        }
//        
//        for _ in 0..<1000 {
//            try await withMainSerialExecutor {
//                try await test()
//            }
//        }
//    }
    
    // MARK: - Cancel
    
    func testFetchRandomNumberButtonTappedAndCancelButtonTapped() async throws {
        
        func test() async throws {
            // MARK: Given
            let testNumber = Int.random(in: 0...100)
            let apiClientMock = APIClientMock1()
            await apiClientMock.setRandomNumber(testNumber)
            sut = SecondViewState(apiClient: apiClientMock)
            XCTAssertNil(sut.number)
            
            // MARK: When
            try sut.fetchRandomNumberButtonTapped()
            
            // MARK: Then
            await Task.yield()
            XCTAssertTrue(sut.isConnecting)
            
            sut.handleCancelButtonTapped()
            
            _ = try await sut.fetchRandomNumberTask?.value
            
            print("🐱: \(sut.error?.localizedDescription)")
            XCTAssertFalse(sut.isConnecting)
            XCTAssertNil(sut.number)
        }
        
        for _ in 0..<1 {
            try await withMainSerialExecutor {
                try await test()
            }
        }
    }
}
