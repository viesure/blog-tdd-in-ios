//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit
@testable import Diary

class MockViewControllerFactory: ViewControllerFactory {

    let dataSource: DiaryDataSource

    init(dataSource: DiaryDataSource) {
        self.dataSource = dataSource
    }

    fileprivate var stubbedNewEntry: EntryDetailViewController? = nil
    fileprivate var stubbedEntries = Dictionary<Entry, EntryDetailViewController>()
    fileprivate var stubbedDiary: DiaryListViewController? = nil

    func stub(newEntryWith viewController: EntryDetailViewController) {
        stubbedNewEntry = viewController
    }

    func stub(entry: Entry, with viewController: EntryDetailViewController) {
        stubbedEntries[entry] = viewController
    }

    func stub(diaryListWith viewController: DiaryListViewController) {
        stubbedDiary = viewController
    }

    func diaryListViewController(router: DiaryRouter) -> DiaryListViewController {
        guard let stubbedDiary = stubbedDiary else {
            fatalError("View controllers need to be stubbed for the tests")
        }
        return stubbedDiary
    }

    func newEntryViewController(router: DiaryRouter) -> EntryDetailViewController {
        guard let stubbedNewEntry = stubbedNewEntry else {
            fatalError("View controllers need to be stubbed for the tests")
        }
        return stubbedNewEntry
    }

    func entryDetailViewController(entry: Entry, router: DiaryRouter) -> EntryDetailViewController {
        guard let stubbedEntry = stubbedEntries[entry] else {
            fatalError("View controllers need to be stubbed for the tests")
        }
        return stubbedEntry
    }
}
