//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class DiaryRouterTests: BaseTestCase {

    func test_displaysDiaryListController_onlyOnce() {
        router.displayDiaryList()
        router.displayDiaryList()
        router.displayDiaryList()

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, diaryListViewController)
    }

    func test_displaysNewEntryController_fromList() {
        router.displayDiaryList()
        diaryListViewController.navigationItem.rightBarButtonItem?.simulateTap()

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, diaryListViewController)
        XCTAssertEqual(navigationController.viewControllers.last, newEntryViewController)
    }

    func test_displaysEntryDetailsController() {
        router.displayDiaryList()
        router.displayEntryDetail(for: testEntry1)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, diaryListViewController)
        XCTAssertEqual(navigationController.viewControllers.last, entryDetailViewController1)
    }

    func test_displaysDiaryListController_afterEntryDetail() {
        router.displayDiaryList()
        router.displayEntryDetail(for: testEntry1)
        router.displayDiaryList()

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, diaryListViewController)
    }

    func test_displaysEntryDetailsController_onlyOne() {
        router.displayDiaryList()
        router.displayEntryDetail(for: testEntry1)
        router.displayEntryDetail(for: testEntry2)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, diaryListViewController)
        XCTAssertEqual(navigationController.viewControllers.last, entryDetailViewController2)
    }
}
