//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

typealias EntrySelectionCallback = (Entry) -> Void
typealias AddNewEntryCallback = () -> Void

class DiaryListViewController: UIViewController {

    fileprivate(set) var entries: [Entry]
    fileprivate let entrySelectionCallback: EntrySelectionCallback
    fileprivate let entryRemovalCallback: EntrySelectionCallback
    fileprivate let addNewEntryCallback: AddNewEntryCallback

    @IBOutlet weak var entryList: UITableView!
    fileprivate let reuseIdentifier = "Cell"

    init(entries: [Entry],
         entrySelectionCallback: @escaping EntrySelectionCallback,
         entryRemovalCallback: @escaping EntrySelectionCallback,
         addNewEntryCallback: @escaping AddNewEntryCallback) {

        self.entries = entries
        self.entrySelectionCallback = entrySelectionCallback
        self.entryRemovalCallback = entryRemovalCallback
        self.addNewEntryCallback = addNewEntryCallback

        super.init(nibName: String(describing: DiaryListViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        print("init(coder:) has not been implemented")
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupEntryList()
    }
}

// MARK: Navigation bar

extension DiaryListViewController {

    fileprivate func setupNavigationBar() {
        title = "Diary"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
    }

    @objc func addButtonTapped(_ sender: Any) {
        addNewEntryCallback()
    }
}

// MARK: Entry list

extension DiaryListViewController: UITableViewDelegate, UITableViewDataSource {

    fileprivate func setupEntryList() {
        entryList.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let entry = entries[indexPath.row]

        cell.textLabel?.text = entry.text.truncate(length: 80)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = entry.date.dateString()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        entryList.deselectRow(at: indexPath, animated: true)
        entrySelectionCallback(entries[indexPath.row])
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            entryRemovalCallback(entries[indexPath.row])
        }
    }
}
