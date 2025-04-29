//
//  GetComicsUseCaseTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 4/4/25.
//

import XCTest
@testable import WallaMarvel

final class GetComicsUseCaseTests: XCTestCase {

    private var mockRepo: MockMarvelRepository!
    private var useCase: GetComics!

    override func setUp() {
        super.setUp()
        mockRepo = MockMarvelRepository()
        useCase = GetComics(repository: mockRepo)
    }

    override func tearDown() {
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }

    func test_execute_callsRepositoryWithCorrectHeroId_andReturnsComics() {
        // Given
        let expectedComics = [
            Comic(id: 1, title: "Infinity War", description: "some", pageCount: 12, thumbnail: nil, dates: []),
            Comic(id: 2, title: "Civil War", description: "some", pageCount: 12, thumbnail: nil, dates: [])
        ]
        mockRepo.comicsToReturn = expectedComics

        var receivedComics: [Comic]?

        // When
        useCase.execute(heroId: 101) { comics in
            receivedComics = comics
        }

        // Then
        XCTAssertEqual(mockRepo.receivedHeroId, 101)
        XCTAssertEqual(receivedComics?.count, 2)
        XCTAssertEqual(receivedComics?.first?.title, "Infinity War")
    }
}
