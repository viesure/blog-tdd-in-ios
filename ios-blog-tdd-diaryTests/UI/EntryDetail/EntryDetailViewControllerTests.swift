//
//  Copyright © 2020 Viesure. All rights reserved.
//

import XCTest
@testable import Diary

class EntryDetailViewControllerTests: BaseTestCase {

    func test_required_initWithCoder() {
        XCTAssertNil(EntryDetailViewController(coder: NSCoder()))
    }

    func test_viewDidLoad_rendersTitle() {
        XCTAssertEqual(makeSUT().title, Date().dateString())
        XCTAssertEqual(makeSUT(entry: testEntry1).title, testEntry1.date.dateString())
    }

    func test_viewDidLoad_rendersSaveButton() {
        XCTAssertEqual(makeSUT().navigationItem.rightBarButtonItem?.title, "Save")
        XCTAssertEqual(makeSUT(entry: testEntry1).navigationItem.rightBarButtonItem?.title, "Update")
    }

    func test_viewDidLoad_insertMode_rendersEmptyTextView() {
        XCTAssertEqual(makeSUT().textView.text, "")
    }

    func test_viewDidLoad_editMode_rendersFilledTextView() {
        XCTAssertEqual(makeSUT(entry: testEntry1).textView.text, testEntry1.text)
    }

    func test_saveButton_isEnabledIsControlledByTextView() {
        let sut = makeSUT()

        sut.textView.text = ""
        sut.textViewDidChange(sut.textView)
        XCTAssertFalse(sut.navigationItem.rightBarButtonItem!.isEnabled)

        sut.textView.text = testEntry1.text
        sut.textViewDidChange(sut.textView)
        XCTAssertTrue(sut.navigationItem.rightBarButtonItem!.isEnabled)
    }

    func test_saveButton_savesEntryCorrectly() {
        var savedEntry: Entry? = nil
        makeSUT(entry: testEntry1, saveEntryCallback: { savedEntry = $0 }).navigationItem.rightBarButtonItem?.simulateTap()
        XCTAssertEqual(savedEntry, testEntry1)
    }

    // MARK: Helpers

    fileprivate func makeSUT(entry: Entry? = nil, saveEntryCallback: @escaping SaveEntryCallback = { _ in}) -> EntryDetailViewController {
        let controller = EntryDetailViewController(entry: entry, saveEntryCallback: saveEntryCallback)
        let _ = controller.view
        return controller
    }
}
