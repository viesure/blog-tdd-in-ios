//
//  Copyright © 2020 Viesure. All rights reserved.
//

import Foundation
@testable import Diary

extension Entry: Hashable {

    public static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.date == rhs.date
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(Int(date.timeIntervalSince1970))
    }
}
