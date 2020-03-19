//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

typealias SaveEntryCallback = (Entry) -> Void

class EntryDetailViewController: UIViewController {

    fileprivate(set) var entry: Entry?
    fileprivate let saveEntryCallback: SaveEntryCallback

    @IBOutlet weak var textView: UITextView!

    init(entry: Entry?,
         saveEntryCallback: @escaping SaveEntryCallback) {

        self.entry = entry
        self.saveEntryCallback = saveEntryCallback
        super.init(nibName: String(describing: EntryDetailViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        print("init(coder:) has not been implemented")
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextView()
        setupNavigationBar()
    }

    fileprivate lazy var saveButton: UIBarButtonItem = {
        UIBarButtonItem(title: nil, style: .done, target: self, action: #selector(saveButtonTapped))
    }()
}

// MARK: Navigation bar

extension EntryDetailViewController {

    fileprivate func setupNavigationBar() {
        title = (entry?.date ?? Date()).dateString()
        navigationItem.rightBarButtonItem = saveButton
        updateNavigationBar()
    }

    @objc func saveButtonTapped(_ sender: Any) {
        saveEntryCallback(Entry(date: entry?.date ?? Date(), text: textView.text))
        navigationController?.popViewController(animated: true)
    }

    fileprivate func updateNavigationBar() {
        saveButton.title = entry != nil ? "Update" : "Save"
        navigationItem.rightBarButtonItem?.isEnabled = !textView.text.isEmpty
    }
}

// MARK: Text view

extension EntryDetailViewController: UITextViewDelegate {

    fileprivate func setupTextView() {
        textView.text = entry?.text
        textView.becomeFirstResponder()
    }

    func textViewDidChange(_ textView: UITextView) {
        updateNavigationBar()
    }
}
