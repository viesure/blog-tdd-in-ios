//
//  Copyright © 2020 Viesure. All rights reserved.
//

import Foundation

class DiaryDataSource: EntryDataSource {

    fileprivate var entries: [Entry] = []

    var sortedEntries: [Entry] {
        entries.sorted { $0.date > $1.date }
    }

    func save(entry: Entry) {
        entries.removeAll(where: { $0.date == entry.date })
        entries.append(entry)
    }

    func remove(entry: Entry) {
        entries.removeAll(where: { $0.date == entry.date })
    }
}
