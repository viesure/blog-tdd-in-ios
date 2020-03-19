//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

final class DiaryViewControllerFactory: ViewControllerFactory {

    let dataSource: DiaryDataSource

    init(dataSource: DiaryDataSource) {
        self.dataSource = dataSource
    }

    func diaryListViewController(router: DiaryRouter) -> DiaryListViewController {
        return DiaryListViewController(
            entries: dataSource.sortedEntries,
            entrySelectionCallback: { router.displayEntryDetail(for: $0) },
            entryRemovalCallback: { [weak self] entry in
                self?.dataSource.remove(entry: entry)
                router.displayDiaryList()
            },
            addNewEntryCallback: { router.displayNewEntry() })
    }

    func newEntryViewController(router: DiaryRouter) -> EntryDetailViewController {
        return EntryDetailViewController(entry: nil,
                                         saveEntryCallback: saveEntryCallback(router: router))
    }

    func entryDetailViewController(entry: Entry, router: DiaryRouter) -> EntryDetailViewController {
        return EntryDetailViewController(entry: entry,
                                         saveEntryCallback: saveEntryCallback(router: router))
    }

    // MARK: Helpers

    fileprivate func saveEntryCallback(router: DiaryRouter) -> (Entry) -> Void {
        return { [weak self] entry in
            self?.dataSource.save(entry: entry)
            router.displayDiaryList()
        }
    }
}
