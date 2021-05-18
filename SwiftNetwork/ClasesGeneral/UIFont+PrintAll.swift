/**
 *  https://gist.github.com/tadija/cb4ec0cbf0a89886d488d1d8b595d0e9
 *  Copyright (c) Marko Tadić 2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

extension UIFont {
    static func printAll() {
        familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                print("\(fontName)")
            }
            print("---------------------")
        }
    }
}