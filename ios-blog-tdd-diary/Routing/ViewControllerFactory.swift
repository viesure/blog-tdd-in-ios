//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

/// Describes what kind of view controller can be created by a factory
protocol ViewControllerFactory {

    /// In our example the factory is the source of the data
    var dataSource: DiaryDataSource { get }

    /// Creates an entry list view controller
    /// - Parameters:
    ///   - router: Passed reference to the router
    func diaryListViewController(router: DiaryRouter) -> DiaryListViewController

    /// Creates a new entry view controller
    /// - Parameter router: Passed reference to the router
    func newEntryViewController(router: DiaryRouter) -> EntryDetailViewController

    /// Creates an entry detail view controller with the given entry
    /// - Parameters:
    ///   - router: Passed reference to the router
    func entryDetailViewController(entry: Entry,
                                   router: DiaryRouter) -> EntryDetailViewController
}
