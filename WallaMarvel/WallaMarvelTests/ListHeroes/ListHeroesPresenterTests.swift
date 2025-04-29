//
//  Untitled.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 4/4/25.
//

import XCTest
@testable import WallaMarvel

final class ListHeroesPresenterTests: XCTestCase {
    
    private var presenter: ListHeroesPresenter!
    private var mockUseCase: MockGetHeroesUseCase!
    private var mockUI: MockListHeroesUI!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetHeroesUseCase()
        mockUI = MockListHeroesUI()
        presenter = ListHeroesPresenter(getHeroesUseCase: mockUseCase)
        presenter.ui = mockUI
    }

    override func tearDown() {
        presenter = nil
        mockUseCase = nil
        mockUI = nil
        super.tearDown()
    }

    func test_getHeroes_updatesOffsetCorrectly() {
        // Given
        let expectation = self.expectation(description: "Wait for update callback")
        
        let characters = (1...20).map { CharacterDataModel.mock(id: $0, name: "Hero \($0)") }
        let container = CharacterDataContainer(count: 20, limit: 20, offset: 0, characters: characters)
        mockUseCase.result = container
        
        mockUI.onUpdate = {
            expectation.fulfill()
        }

        // When
        presenter.getHeroes()

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockUseCase.lastOffset, 0)
        XCTAssertTrue(mockUseCase.executeCalled)
        XCTAssertEqual(mockUI.updatedHeroes?.count, 20)
    }
    
    func test_filterHeroes_resetsOffsetAndTriggersSearch() {
        // Given
        let expectation = self.expectation(description: "Wait for filtered update")

        let filteredCharacters = [
            CharacterDataModel.mock(id: 101, name: "Spider-Man")
        ]
        let container = CharacterDataContainer(count: 1, limit: 20, offset: 0, characters: filteredCharacters)
        mockUseCase.result = container
        
        mockUI.onUpdate = {
            if self.mockUI.updatedHeroes == filteredCharacters {
                expectation.fulfill()
            }
        }

        // When
        presenter.filterHeroes(with: "spider")

        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockUseCase.lastOffset, 0)
        XCTAssertEqual(mockUseCase.lastQuery, "spider")
        XCTAssertEqual(mockUI.updatedHeroes, filteredCharacters)
    }
    
    func test_filterHeroes_doesNotCallUseCaseWhenQueryIsSame() {
        // Given
        let characters = [CharacterDataModel.mock(name: "Hulk")]
        let container = CharacterDataContainer(count: 1, limit: 20, offset: 0, characters: characters)
        mockUseCase.result = container

        // When: first call
        presenter.filterHeroes(with: "hulk")
        mockUI.updatedHeroes = characters

        // Reset state
        mockUseCase.executeCalled = false
        mockUseCase.executeCallCount = 0

        // When: second call
        presenter.filterHeroes(with: "hulk")

        // Then
        XCTAssertFalse(mockUseCase.executeCalled, "It shouldn't call again if query is the same.")
        XCTAssertEqual(mockUseCase.executeCallCount, 0)
    }
    
    func test_getHeroes_appendsHeroesOnPaginationAndNotReplacing() {
        // Given
        let expectation = self.expectation(description: "Wait for pagination updates")
        expectation.expectedFulfillmentCount = 2
        
        let firstBatch = [
            CharacterDataModel.mock(id: 1, name: "Iron Man"),
            CharacterDataModel.mock(id: 2, name: "Captain America")
        ]
        let secondBatch = [
            CharacterDataModel.mock(id: 3, name: "Thor"),
            CharacterDataModel.mock(id: 4, name: "Hulk")
        ]

        let firstContainer = CharacterDataContainer(count: 2, limit: 2, total: 4, offset: 0, characters: firstBatch)
        let secondContainer = CharacterDataContainer(count: 2, limit: 2, total: 4, offset: 2, characters: secondBatch)

        mockUI.onUpdate = {
            if self.mockUI.updatedHeroes == firstBatch {
                self.mockUseCase.result = secondContainer
                self.presenter.getHeroes()
            }
            expectation.fulfill()
        }
        
        // When
        mockUseCase.result = firstContainer
        presenter.getHeroes()
        
        // Then
        wait(for: [expectation], timeout: 2.0)

        let expected = firstBatch + secondBatch
        XCTAssertEqual(mockUI.updatedHeroes, expected)
    }
    
    func test_getHeroes_showsLoadingAndHidesAfterCompletion() {
        // Given
        let expectation = self.expectation(description: "Wait for loading states and update")

        let characters = (1...3).map { CharacterDataModel.mock(id: $0) }
        let container = CharacterDataContainer(count: 3, limit: 20, offset: 0, characters: characters)
        mockUseCase.result = container

        mockUI.onUpdate = {
            expectation.fulfill()
        }

        // When
        presenter.getHeroes()

        // Then
        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(mockUI.loadingStates.first, true, "Must show loading when starting")
        XCTAssertEqual(mockUI.loadingStates.last, false, "Must hide loading after finishing")
    }
    
    func test_screenTitle_returnsExpectedTitle() {
        // When
        let title = presenter.screenTitle()
        
        // Then
        XCTAssertEqual(title, "List of Heroes")
    }
    
    func test_filterHeroes_trimsAndLowercasesQuery() {
        // Given
        let characters = [CharacterDataModel.mock(name: "Iron Man")]
        let container = CharacterDataContainer(count: 1, limit: 20, offset: 0, characters: characters)
        mockUseCase.result = container

        // When
        presenter.filterHeroes(with: "  IRON Man  ")

        // Then
        XCTAssertEqual(mockUseCase.lastQuery, "iron man")
    }
    
    func test_getHeroes_handlesEmptyResultsGracefully() {
        // Given
        let expectation = self.expectation(description: "Wait for update on empty result")

        let emptyContainer = CharacterDataContainer(count: 0, limit: 20, total: 0, offset: 0, characters: [])
        mockUseCase.result = emptyContainer

        mockUI.onUpdate = {
            expectation.fulfill()
        }

        // When
        presenter.getHeroes()

        // Then
        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(mockUI.updatedHeroes, [], "UI must recieve an empty array without crashes")
    }

}
