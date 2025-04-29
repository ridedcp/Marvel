import XCTest

class WallaMarvelUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {}

    func test_heroList_showsTableAndFirstCellCanBeTapped() throws {
        let app = XCUIApplication()

        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 2), "TableView does not appear")

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell does not exist")

        firstCell.tap()
    }
    
    func test_heroList_opensHeroDetailScreen_onCellTap() throws {
        let app = XCUIApplication()
        
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5))

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()

        let navBar = app.navigationBars.element
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "Did not navigate to detail view")
        
        let title = navBar.staticTexts.element(boundBy: 0).label
        XCTAssertEqual(title, "3-D Man")
        XCTAssertNotEqual(title, "Iron Man")
    }
    
    func test_searchNoResults_showsEmptyStateLabel() throws {
        let app = XCUIApplication()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 2), "Did not found search bar")

        searchField.tap()
        searchField.typeText("sdfasdfasfd")

        let emptyLabel = app.staticTexts["emptyStateLabel"]
        XCTAssertTrue(emptyLabel.waitForExistence(timeout: 3), "Empty state not appearing")
        XCTAssertEqual(emptyLabel.label, "No heroes found")
    }
    
    func test_heroDetail_canGoBackToList() throws {
        let app = XCUIApplication()
        
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5))

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()

        let navBar = app.navigationBars.element
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "Detail view did not load")

        let backButton = navBar.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        XCTAssertTrue(table.waitForExistence(timeout: 5), "Did not return to hero list")
    }
    
    func test_openComicDetailView_displaysComicTitle() {
        let app = XCUIApplication()
        app.launch()

        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.waitForExistence(timeout: 2), "List of heroes not loaded")
        tableView.cells.firstMatch.tap()

        let collection = app.collectionViews.firstMatch
        XCTAssertTrue(collection.waitForExistence(timeout: 2), "Comics collection not found")

        guard collection.cells.count > 0 else {
            XCTFail("No comic cells found to tap")
            return
        }

        collection.cells.firstMatch.tap()

        let comicTitle = app.staticTexts["comicDetailTitle"]
        XCTAssertTrue(comicTitle.waitForExistence(timeout: 2), "Comic detail title not displayed")
    }

    func testLaunchPerformance() throws {}
}
