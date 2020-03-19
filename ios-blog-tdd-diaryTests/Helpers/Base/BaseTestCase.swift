//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class BaseTestCase: XCTestCase {

    // MARK: Test data

    let testDate1 = Date()
    var testDate2: Date { testDate1.addingTimeInterval(3600 * 1) }
    var testDate3: Date { testDate1.addingTimeInterval(3600 * 2) }

    let testText1 = "First entry text. This one is very long to make sure we also test the case when the entry's message is too long for the cell, so it gets trimmed"
    let testText2 = "Second entry text"
    let testText3 = "Third entry text"
    let testUpdatedText = "Updated entry text"

    lazy var testEntry1: Entry = { Entry(date: testDate1, text: testText1) }()
    lazy var testEntry2: Entry = { Entry(date: testDate2, text: testText2) }()
    lazy var testEntry3: Entry = { Entry(date: testDate3, text: testText3) }()

    let dataSource = DiaryDataSource()
    let navigationController = MockNavigationController()

    lazy var factory: MockViewControllerFactory = {
        MockViewControllerFactory(dataSource: dataSource)
    }()

    lazy var router: DiaryRouter = {
        DiaryRouter(navigationController: navigationController, factory: factory)
    }()

    lazy var diaryListViewController: DiaryListViewController = {
        DiaryListViewController(
            entries: dataSource.sortedEntries,
            entrySelectionCallback: { self.router.displayEntryDetail(for: $0) },
            entryRemovalCallback: { entry in
                self.dataSource.remove(entry: entry)
                self.router.displayDiaryList()
        },
            addNewEntryCallback: { self.router.displayNewEntry() })
    }()

    lazy var entryDetailViewController1 = {
        EntryDetailViewController(entry: testEntry1, saveEntryCallback: { self.dataSource.save(entry: $0) })
    }()

    lazy var entryDetailViewController2 = {
        EntryDetailViewController(entry: testEntry2, saveEntryCallback: { self.dataSource.save(entry: $0) })
    }()

    lazy var newEntryViewController = {
        EntryDetailViewController(entry: nil, saveEntryCallback: { self.dataSource.save(entry: $0) })
    }()

    override func setUp() {
        // Force-loading the views
        let _ = diaryListViewController.view
        let _ = entryDetailViewController1.view
        let _ = entryDetailViewController2.view
        let _ = newEntryViewController.view

        // Stubbing the view controllers
        factory.stub(diaryListWith: diaryListViewController)
        factory.stub(newEntryWith: newEntryViewController)
        factory.stub(entry: testEntry1, with: entryDetailViewController1)
        factory.stub(entry: testEntry2, with: entryDetailViewController2)
    }

    // MARK: Test factory

    lazy var testFactory: DiaryViewControllerFactory = {
        DiaryViewControllerFactory(dataSource: dataSource)
    }()

    lazy var testRouter: DiaryRouter = {
        let router = DiaryRouter(navigationController: navigationController, factory: testFactory)
        router.displayDiaryList()
        return router
    }()

    func makeDiaryListController() -> DiaryListViewController {
        let controller = testFactory.diaryListViewController(router: testRouter)
        let _ = controller.view
        return controller
    }

    func makeEntryDetailController(entry: Entry) -> EntryDetailViewController {
        let controller = testFactory.entryDetailViewController(entry: entry, router: testRouter)
        let _ = controller.view
        return controller
    }

    func makeNewEntryController() -> EntryDetailViewController {
        let controller = testFactory.newEntryViewController(router: testRouter)
        let _ = controller.view
        return controller
    }
}
