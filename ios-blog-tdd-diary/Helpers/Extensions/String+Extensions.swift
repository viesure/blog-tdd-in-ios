//
//  Copyright © 2020 Viesure. All rights reserved.
//

import Foundation

extension String {

    func truncate(length: Int, trailing: String = "…") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        }
        return self
    }
}
