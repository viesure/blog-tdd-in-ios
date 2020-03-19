//
//  Copyright © 2020 Viesure. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    func simulateTap() {
        guard let action = action else { return }
        target?.performSelector(onMainThread: action, with: nil, waitUntilDone: true)
    }
}
