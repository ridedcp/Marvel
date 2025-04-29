//
//  MarvelDataSourceTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import XCTest
@testable import WallaMarvel

final class MarvelDataSourceTests: XCTestCase {

    private var mockClient: MockAPIClient!
    private var dataSource: MarvelDataSource!

    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
        dataSource = MarvelDataSource(apiClient: mockClient)
    }

    override func tearDown() {
        mockClient = nil
        dataSource = nil
        super.tearDown()
    }

    func test_getHeroes_callsAPIClientWithCorrectParams_andReturnsResult() {
        // Given
        let expectedContainer = CharacterDataContainer(count: 1, limit: 20, total: 100, offset: 0, characters: [CharacterDataModel.mock()])
        mockClient.heroesToReturn = expectedContainer

        var result: CharacterDataContainer?

        // When
        dataSource.getHeroes(offset: 0, query: "thor") {
            result = $0
        }

        // Then
        XCTAssertEqual(mockClient.receivedOffset, 0)
        XCTAssertEqual(mockClient.receivedQuery, "thor")
        XCTAssertEqual(result?.characters.first?.name, "Mock Hero")
    }

    func test_getComics_callsAPIClientWithCorrectHeroId_andReturnsComics() {
        // Given
        let expectedComics = [
            Comic(id: 1, title: "Thor: Ragnarok", description: "some", pageCount: 12, thumbnail: nil, dates: []),
            Comic(id: 2, title: "Avengers Assemble", description: "some", pageCount: 10, thumbnail: nil, dates: [])
        ]
        mockClient.comicsToReturn = expectedComics

        var result: [Comic] = []

        // When
        dataSource.getComics(for: 99) {
            result = $0
        }

        // Then
        XCTAssertEqual(mockClient.receivedHeroId, 99)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.title, "Thor: Ragnarok")
    }
}
