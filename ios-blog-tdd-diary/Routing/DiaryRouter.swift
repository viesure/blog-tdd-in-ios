//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

final class DiaryRouter: DiaryRouting {

    fileprivate let navigationController: UINavigationController
    fileprivate let factory: ViewControllerFactory

    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func displayDiaryList() {
        let controller = factory.diaryListViewController(router: self)
        navigationController.viewControllers = [controller]
    }

    func displayNewEntry() {
        resetToDiaryList()

        let controller = factory.newEntryViewController(router: self)
        navigationController.pushViewController(controller, animated: true)
    }

    func displayEntryDetail(for entry: Entry) {
        resetToDiaryList()

        let controller = factory.entryDetailViewController(entry: entry, router: self)
        navigationController.pushViewController(controller, animated: true)
    }

    // MARK: Helpers

    fileprivate func resetToDiaryList() {
        if navigationController.viewControllers.count != 1 { displayDiaryList() }
    }
}
