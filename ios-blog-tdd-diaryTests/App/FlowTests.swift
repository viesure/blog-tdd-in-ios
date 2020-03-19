//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class FlowTests: BaseTestCase {

    func test_startingAddingNewEntries() {
        let controller = makeDiaryListController()
        XCTAssertEqual(controller.entryList.numberOfRows(inSection: 0), 0)
        controller.navigationItem.rightBarButtonItem?.simulateTap()

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        guard let _ = navigationController.viewControllers[1] as? EntryDetailViewController else {
            return XCTFail("Entry detail screen hasn't been created after tapping on the add button")
        }
    }

    func test_savingNewEntry() {
        let controller = makeNewEntryController()
        controller.textView.text = testText1
        controller.textViewDidChange(controller.textView)
        controller.navigationItem.rightBarButtonItem?.simulateTap()

        XCTAssertEqual(dataSource.sortedEntries.count, 1)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        guard let _ = navigationController.viewControllers[0] as? DiaryListViewController else {
            return XCTFail("Diary list screen hasn't been created after saving an entry")
        }
    }

    func test_removingAnEntry() {
        dataSource.save(entry: testEntry1)
        dataSource.save(entry: testEntry2)
        dataSource.save(entry: testEntry3)

        let controller = makeDiaryListController()
        XCTAssertEqual(controller.entryList.numberOfRows(inSection: 0), 3)
        controller.entryList.remove(row: 1)

        // A new list is created and added as the root view controller at this point
        guard let newController = navigationController.viewControllers[0] as? DiaryListViewController else {
            return XCTFail("New list hasn't been created after removing an entry")
        }

        let _ = newController.view
        XCTAssertEqual(newController.entryList.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(dataSource.sortedEntries.count, 2)
    }

    func test_entrySelection() {
        dataSource.save(entry: testEntry1)
        dataSource.save(entry: testEntry2)

        let controller = makeDiaryListController()
        XCTAssertEqual(controller.entryList.numberOfRows(inSection: 0), 2)
        controller.entryList.select(row: 1)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        guard let _ = navigationController.viewControllers[1] as? EntryDetailViewController else {
            return XCTFail("Entry detail screen hasn't been created after selecting an entry")
        }
    }
}
