//
//  Copyright © 2020 Viesure. All rights reserved.
//

import Foundation

/// Describes routing between the supported viewcontrollers
protocol DiaryRouting {

    /// Starts routing by displaying the diary list
    func displayDiaryList()

    /// Navigates to the add new entry screen
    func displayNewEntry()

    /// Navigates to an entry's detail screen
    /// - Parameter entry: the entry to edit
    func displayEntryDetail(for entry: Entry)
}
