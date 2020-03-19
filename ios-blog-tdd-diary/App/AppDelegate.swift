//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Setting up the main navigation controller and start routing to the list
        let navigationController = UINavigationController()
        let factory = DiaryViewControllerFactory(dataSource: DiaryDataSource())
        let router = DiaryRouter(navigationController: navigationController, factory: factory)
        router.displayDiaryList()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
