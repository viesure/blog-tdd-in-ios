//
//  Copyright © 2020 Viesure. All rights reserved.
//

import Foundation

/// Describes what an entry data source is capable of
protocol EntryDataSource {

    /// Returns the sorted list of all entries
    var sortedEntries: [Entry] { get }

    /// Adds or updates the given entry
    /// - Parameter entry: The entry to be inserted or updated
    func save(entry: Entry)

    /// Removes the given entry
    /// - Parameter entry: The entry to be removed
    func remove(entry: Entry)
}
