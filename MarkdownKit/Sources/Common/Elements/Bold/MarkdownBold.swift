//
//  MarkdownBold.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownBold: MarkdownCommonElement {
  fileprivate static let regex = "([^_]|^)(\\*\\*|__)(.+?)(?<=)(\\2)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  
  open var regex: String {
    return MarkdownBold.regex
  }
  
  public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
    self.font = font?.bold()
    self.color = color
  }
    
    public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        /* These will be kept here for debugging purposes. Uncomment to see the regular expression at work */
//        print("range 0 (bold): \(attributedString.attributedSubstring(from: match.range(at: 0)).string)")
//        print("range 1: \(attributedString.attributedSubstring(from: match.range(at: 1)).string)")
//        print("range 2: \(attributedString.attributedSubstring(from: match.range(at: 2)).string)")
//        print("range 3: \(attributedString.attributedSubstring(from: match.range(at: 3)).string)")
//        print("range 4: \(attributedString.attributedSubstring(from: match.range(at: 4)).string)")
        
        /* This checks if the matched attributedString from the regex is part of a link.
         If so, don't apply the bold attribute to the attributedString.
         Note: this only works if the bold tag is not at the beginning of the string.
         */
        let currentAttributes = attributedString.attributedSubstring(from: match.range).attributes(at: 0, effectiveRange: nil).map{$0.key.rawValue}
        if currentAttributes.contains("NSLink") {
            return
        }
        
        // deleting trailing markdown
        attributedString.deleteCharacters(in: match.range(at: 4))
        // formatting string (may alter the length)
        addAttributes(attributedString, range: match.range(at: 3))
        // deleting leading markdown
        attributedString.deleteCharacters(in: match.range(at: 2))
    }
}
