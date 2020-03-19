//
//  Copyright © 2020 Viesure. All rights reserved.
//

import Foundation

extension Date {

    public func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        return formatter.string(from: self)
    }
}
