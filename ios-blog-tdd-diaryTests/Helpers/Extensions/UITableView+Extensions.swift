//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

extension UITableView {

    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }

    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }

    func select(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: indexPath)
    }

    func remove(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        dataSource?.tableView?(self, commit: .delete, forRowAt: indexPath)
    }
}
