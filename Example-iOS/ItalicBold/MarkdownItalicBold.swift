//
//  MarkdownItalicBold.swift
//  MarkdownKit
//
//  Created by Haamed Sultani on 2020-02-11.
//  Copyright © 2020 Ivan Bruel. All rights reserved.
//

import Foundation
import MarkdownKit

open class  MarkdownItalicBold: MarkdownCommonElement {
    
    fileprivate static let regex = "(_)(\\*\\*)(.+?)(?<=)(\\2)(\\1)"
    
    // TODO: implement markdown methods
    open var font: MarkdownFont?
    open var color: MarkdownColor?
    
    open var regex: String {
        return MarkdownItalicBold.regex
    }
    
    public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
        if font == nil {
            self.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize).italicBold()
        } else {
            self.font = font?.italicBold()
        }
        self.color = color
    }
    
    public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        /* These will be kept here for debugging purposes. Uncomment to see the regular expression at work */
//        print("range 0 (italic bold): \(attributedString.attributedSubstring(from: match.range(at: 0)).string)")
//        print("range 1: \(attributedString.attributedSubstring(from: match.range(at: 1)).string)")
//        print("range 2: \(attributedString.attributedSubstring(from: match.range(at: 2)).string)")
//        print("range 3: \(attributedString.attributedSubstring(from: match.range(at: 3)).string)")
//        print("range 4: \(attributedString.attributedSubstring(from: match.range(at: 4)).string)")
//        print("range 5: \(attributedString.attributedSubstring(from: match.range(at: 5)).string)")
        // deleting trailing markdown
        attributedString.deleteCharacters(in: match.range(at: 5))
        attributedString.deleteCharacters(in: match.range(at: 4))
        // formatting string (may alter the length)
        addAttributes(attributedString, range: match.range(at: 3))
        // deleting leading markdown
        attributedString.deleteCharacters(in: match.range(at: 2))
        attributedString.deleteCharacters(in: match.range(at: 1))
        print("whats left after changes (italic bold): \(attributedString.attributedSubstring(from: match.range(at: 1)).string)")
    }
}

extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func italicBold() -> UIFont? {
        return withTraits([.traitItalic, .traitBold])
    }
}
