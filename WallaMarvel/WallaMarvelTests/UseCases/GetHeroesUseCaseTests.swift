//
//  GetHeroesUseCaseTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import XCTest
@testable import WallaMarvel

final class GetHeroesUseCaseTests: XCTestCase {

    private var mockRepo: MockMarvelRepository!
    private var useCase: GetHeroes!

    override func setUp() {
        super.setUp()
        mockRepo = MockMarvelRepository()
        useCase = GetHeroes(repository: mockRepo)
    }

    override func tearDown() {
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }

    func test_execute_callsRepositoryWithCorrectParams_andPropagatesResult() {
        // Given
        let expectedResult = CharacterDataContainer(count: 1, limit: 20, total: 100, offset: 0, characters: [CharacterDataModel.mock()])
        mockRepo.resultContainer = expectedResult

        var receivedResult: CharacterDataContainer?

        // When
        useCase.execute(offset: 0, query: "spider") { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(mockRepo.receivedOffset, 0)
        XCTAssertEqual(mockRepo.receivedQuery, "spider")
        XCTAssertEqual(receivedResult?.characters.count, 1)
        XCTAssertEqual(receivedResult?.characters.first?.name, "Mock Hero")
    }
}
