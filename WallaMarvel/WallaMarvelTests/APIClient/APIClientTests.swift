//
//  APIClientTests.swift
//  WallaMarvelTests
//
//  Created by Daniel Cano on 5/4/25.
//

import XCTest
@testable import WallaMarvel

final class APIClientTests: XCTestCase {
    
    private var client: APIClient!
    
    override func setUp() {
        super.setUp()
        MockURLProtocol.mockResponseData = nil
        MockURLProtocol.mockError = nil
        client = APIClient.makeMockedClient()
    }
    
    override func tearDown() {
        MockURLProtocol.mockResponseData = nil
        MockURLProtocol.mockError = nil
        client = nil
        super.tearDown()
    }

    func test_getHeroes_decodesCharacterDataContainerSuccessfully() throws {
        // Given
        let json = """
        {
            "data": {
                "offset": 0,
                "limit": 20,
                "total": 100,
                "count": 1,
                "results": [
                    {
                        "id": 123,
                        "name": "Test Hero",
                        "thumbnail": {
                            "path": "http://example.com/image",
                            "extension": "jpg"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = json
        
        let expectation = self.expectation(description: "Wait for response")
        
        // When
        client.getHeroes(offset: 0, query: nil) { container in
            // Then
            XCTAssertEqual(container.characters.first?.id, 123)
            XCTAssertEqual(container.characters.first?.name, "Test Hero")
            XCTAssertEqual(container.characters.first?.thumbnail.path, "http://example.com/image")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getComics_decodesComicsSuccessfully() throws {
        // Given
        let json = """
        {
            "data": {
                "results": [
                    {
                        "id": 42,
                        "title": "Infinity Gauntlet",
                        "description": "A cosmic battle",
                        "pageCount": 48,
                        "thumbnail": {
                            "path": "http://example.com/image1",
                            "extension": "jpg"
                        },
                        "dates": [
                            {
                                "type": "onsaleDate",
                                "date": "1991-07-01T00:00:00-0400"
                            }
                        ]
                    },
                    {
                        "id": 43,
                        "title": "Secret Wars",
                        "description": "The ultimate showdown",
                        "pageCount": 52,
                        "thumbnail": {
                            "path": "http://example.com/image2",
                            "extension": "jpg"
                        },
                        "dates": [
                            {
                                "type": "onsaleDate",
                                "date": "1984-05-01T00:00:00-0400"
                            }
                        ]
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = json
        let expectation = self.expectation(description: "Wait for comics response")
        var receivedComics: [Comic]?
        
        // When
        client.getComics(for: 123) { comics in
            receivedComics = comics
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(receivedComics?.count, 2)
        XCTAssertEqual(receivedComics?.first?.id, 42)
        XCTAssertEqual(receivedComics?.first?.title, "Infinity Gauntlet")
        XCTAssertEqual(receivedComics?.first?.description, "A cosmic battle")
        XCTAssertEqual(receivedComics?.first?.pageCount, 48)
        XCTAssertEqual(receivedComics?.first?.thumbnail?.path, "http://example.com/image1")
        XCTAssertEqual(receivedComics?.first?.thumbnail?.extension, "jpg")
        XCTAssertEqual(receivedComics?.first?.dates.first?.type, "onsaleDate")
        XCTAssertEqual(receivedComics?.first?.dates.first?.date, "1991-07-01T00:00:00-0400")
    }

    
    func test_getComics_whenNetworkError_returnsEmptyArray() {
        // Given
        MockURLProtocol.mockError = NSError(domain: "test", code: -1)
        
        let expectation = self.expectation(description: "Wait for network error")
        var receivedComics: [Comic]?
        
        // When
        client.getComics(for: 888) { comics in
            receivedComics = comics
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedComics, [], "Expected empty array on network error")
    }
    
    func test_getComics_whenDecodingFails_returnsEmptyArray() {
        // Given
        let invalidJSON = """
        {
            "data": {
                "wrongKey": []
            }
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.mockResponseData = invalidJSON
        
        let expectation = self.expectation(description: "Wait for failure response")
        var receivedComics: [Comic]?
        
        // When
        client.getComics(for: 999) { comics in
            receivedComics = comics
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedComics, [], "Expected empty array on decoding error")
    }
}
