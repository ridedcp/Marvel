//
//  MarvelRepositoryTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import XCTest
@testable import WallaMarvel

final class MarvelRepositoryTests: XCTestCase {

    private var mockDataSource: MockMarvelDataSource!
    private var repository: MarvelRepository!

    override func setUp() {
        super.setUp()
        mockDataSource = MockMarvelDataSource()
        repository = MarvelRepository(dataSource: mockDataSource)
    }

    override func tearDown() {
        mockDataSource = nil
        repository = nil
        super.tearDown()
    }

    func test_getHeroes_callsDataSourceWithCorrectParams_andReturnsResult() {
        // Given
        let expectedResult = CharacterDataContainer(count: 1, limit: 20, total: 100, offset: 0, characters: [CharacterDataModel.mock()])
        mockDataSource.heroesResult = expectedResult

        var receivedResult: CharacterDataContainer?
        
        // When
        repository.getHeroes(offset: 0, query: "hulk") { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(mockDataSource.receivedOffset, 0)
        XCTAssertEqual(mockDataSource.receivedQuery, "hulk")
        XCTAssertEqual(receivedResult?.characters.count, 1)
        XCTAssertEqual(receivedResult?.characters.first?.name, "Mock Hero")
    }

    func test_getComics_callsDataSourceWithCorrectHeroId_andReturnsComics() {
        // Given
        let expectedComics = [
            Comic(id: 1, title: "House of M", description: "some", pageCount: 12, thumbnail: nil, dates: []),
            Comic(id: 2, title: "Planet Hulk", description: "some", pageCount: 12, thumbnail: nil, dates: [])
        ]
        mockDataSource.comicsResult = expectedComics

        var receivedComics: [Comic] = []

        // When
        repository.getComics(for: 101) { comics in
            receivedComics = comics
        }

        // Then
        XCTAssertEqual(mockDataSource.receivedHeroId, 101)
        XCTAssertEqual(receivedComics.count, 2)
        XCTAssertEqual(receivedComics.first?.title, "House of M")
    }
}
