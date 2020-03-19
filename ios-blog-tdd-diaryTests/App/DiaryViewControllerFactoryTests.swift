//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class DiaryViewControllerFactoryTests: BaseTestCase {

    func test_diaryList_rendersControllerWithValidEntries() {
        XCTAssertEqual(makeDiaryListController().entries.count, 0)
        dataSource.save(entry: testEntry1)
        XCTAssertEqual(makeDiaryListController().entries.count, 1)
    }

    func test_newEntry_rendersWithEmptyEntry() {
        XCTAssertNil(makeNewEntryController().entry)
    }

    func test_newEntry_rendersWithEntry() {
        XCTAssertEqual(makeEntryDetailController(entry: testEntry1).entry, testEntry1)
    }
}
