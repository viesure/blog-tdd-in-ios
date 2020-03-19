//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class DiaryListViewControllerTests: BaseTestCase {

    func test_required_initWithCoder() {
        XCTAssertNil(DiaryListViewController(coder: NSCoder()))
    }

    func test_viewDidLoad_rendersTitle() {
        XCTAssertEqual(makeSUT(entries: []).title, "Diary")
    }

    func test_viewDidLoad_rendersEntries() {
        XCTAssertEqual(makeSUT(entries: []).entryList.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(entries: [testEntry1]).entryList.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(entries: [testEntry1, testEntry2]).entryList.numberOfRows(inSection: 0), 2)
    }

    func test_viewDidLoad_rendersEntryTexts() {
        XCTAssertEqual(makeSUT(entries: [testEntry1]).entryList.title(at: 0), testEntry1.text.truncate(length: 80))
        XCTAssertEqual(makeSUT(entries: [testEntry1, testEntry2]).entryList.title(at: 1), testEntry2.text.truncate(length: 80))
    }

    func test_entrySelection_callsEntrySelectedCallback() {
        var selectedEntry: Entry? = nil
        let sut = makeSUT(entries: [testEntry1], entrySelectionCallback: { entry in
            selectedEntry = entry
        })

        sut.entryList.select(row: 0)
        XCTAssertEqual(selectedEntry, testEntry1)
    }

    func test_entryRemoval_callsEntryRemovalCallback() {
        var selectedEntry: Entry? = nil
        let sut = makeSUT(entries: [testEntry1], entryRemovalCallback: { entry in
            selectedEntry = entry
        })

        sut.entryList.remove(row: 0)
        XCTAssertEqual(selectedEntry, testEntry1)
    }

    // MARK: Helpers

    fileprivate func makeSUT(entries: [Entry],
                             entrySelectionCallback: @escaping EntrySelectionCallback = { _ in },
                             entryRemovalCallback: @escaping EntrySelectionCallback = { _ in }) -> DiaryListViewController {

        let controller = DiaryListViewController(entries: entries,
                                                 entrySelectionCallback: entrySelectionCallback,
                                                 entryRemovalCallback: entryRemovalCallback,
                                                 addNewEntryCallback: {})
        let _ = controller.view
        return controller
    }
}
