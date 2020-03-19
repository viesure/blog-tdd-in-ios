//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class DiaryDataSourceTests: BaseTestCase {

    func test_entries_emptyByDefault() {
        XCTAssertEqual(dataSource.sortedEntries.count, 0)
    }

    func test_entries_addsEntry_onlyOnce() {
        dataSource.save(entry: testEntry1)
        dataSource.save(entry: testEntry1)
        dataSource.save(entry: testEntry1)

        XCTAssertEqual(dataSource.sortedEntries.count, 1)
    }

    func test_entries_addsEntry_keepsOrder() {
        dataSource.save(entry: testEntry2)
        dataSource.save(entry: testEntry3)
        dataSource.save(entry: testEntry1)
        let entries = dataSource.sortedEntries

        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries[0].date, testDate3)
        XCTAssertEqual(entries[0].text, testText3)
        XCTAssertEqual(entries[1].date, testDate2)
        XCTAssertEqual(entries[1].text, testText2)
        XCTAssertEqual(entries[2].date, testDate1)
        XCTAssertEqual(entries[2].text, testText1)
    }

    func test_entries_removesFirst() {
        dataSource.save(entry: testEntry1)
        dataSource.save(entry: testEntry2)
        dataSource.remove(entry: testEntry1)

        let entries = dataSource.sortedEntries
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries[0].date, testDate2)
        XCTAssertEqual(entries[0].text, testText2)
    }

    func test_entries_updatesEntry() {
        var entry = testEntry1
        dataSource.save(entry: entry)

        entry.text = testUpdatedText
        dataSource.save(entry: entry)

        let entries = dataSource.sortedEntries
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries[0].date, testDate1)
        XCTAssertEqual(entries[0].text, testUpdatedText)
    }
}
