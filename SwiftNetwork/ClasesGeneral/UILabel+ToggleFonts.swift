/**
 *  https://gist.github.com/tadija/cb4ec0cbf0a89886d488d1d8b595d0e9
 *  Copyright (c) Marko Tadić 2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

extension UILabel {
    func enableTogglingFontsOnTap() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(_:))))
        isUserInteractionEnabled = true
        tag = -1
    }

    @objc
    func didTap(_ sender: UITapGestureRecognizer) {
        toggleFont()
    }

    func toggleFont() {
        tag += 1
        if allFonts.indices ~= tag {
            setFont(allFonts[tag])
        } else {
            tag = -1
            toggleFont()
        }
    }

    func setFont(_ font: UIFont) {
        self.font = font
        print("font: \(font.fontName) | index: \(tag)")
    }

    var allFonts: [UIFont] {
        return UILabel.allFontNames.compactMap { UIFont(name: $0, size: font.pointSize) }
    }

    static let allFontNames: [String] = {
        var fontNames = [String]()
        UIFont.familyNames.sorted().forEach { familyName in
            UIFont.fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                fontNames.append(fontName)
            }
        }
        return fontNames
    }()
}