//
//  MarkdownStrikethrough.swift
//  Pods
//
//  Created by _ on _.
//
//
import Foundation

open class MarkdownStrikethrough: MarkdownCommonElement {
    fileprivate static let regex = "(.?|^)(\\~\\~)(?=)(.+?)(?<=)(\\2)"
    
    open var font: MarkdownFont?
    open var color: MarkdownColor?
    public var attributes: [NSAttributedString.Key : AnyObject] = [ .strikethroughStyle: NSNumber.init(value: NSUnderlineStyle.single.rawValue) ]
    
    open var regex: String {
        return MarkdownStrikethrough.regex
    }
    
    public init(font: MarkdownFont? = nil, color: MarkdownColor? = nil) {
        self.font = font
        self.color = color
    }
    
    public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        // deleting trailing markdown
        attributedString.deleteCharacters(in: match.range(at: 4))
        // formatting string (may alter the length)
        addAttributes(attributedString, range: match.range(at: 3))
        // deleting leading markdown
        attributedString.deleteCharacters(in: match.range(at: 2))
    }
}
