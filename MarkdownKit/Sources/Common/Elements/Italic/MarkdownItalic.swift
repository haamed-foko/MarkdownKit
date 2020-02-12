//
//  MarkdownItalic.swift
//  Pods
//
//  Created by Ivan Bruel on 18/07/16.
//
//
import Foundation

open class MarkdownItalic: MarkdownCommonElement {
  
  fileprivate static let regex = "([^*]|\\s|^)(\\*|_)([^*])(.+?)(\\2)"
  
  open var font: MarkdownFont?
  open var color: MarkdownColor?
  
  open var regex: String {
    return MarkdownItalic.regex
  }
  
  public init(font: MarkdownFont?, color: MarkdownColor? = nil) {
    self.font = font?.italic()
    self.color = color
  }
    
    public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        /* These will be kept here for debugging purposes. Uncomment to see the regular expression at work */
//        print("range 0 (italic): \(attributedString.attributedSubstring(from: match.range(at: 0)).string)")
//        print("range 1: \(attributedString.attributedSubstring(from: match.range(at: 1)).string)")
//        print("range 2: \(attributedString.attributedSubstring(from: match.range(at: 2)).string)")
//        print("range 3: \(attributedString.attributedSubstring(from: match.range(at: 3)).string)")
//        print("range 4: \(attributedString.attributedSubstring(from: match.range(at: 4)).string)")
//        print("range 5: \(attributedString.attributedSubstring(from: match.range(at: 5)).string)")
        
        /* Get string */
        let restOfString = attributedString.string
        
        /* Separate the string using the matched substring from italic regex */
        let componentsOfRestOfString = restOfString.components(separatedBy: attributedString.attributedSubstring(from: match.range(at: 0)).string)
        //print("Separated by: \(attributedString.attributedSubstring(from: match.range(at: 0)).string)")
        if !componentsOfRestOfString.isEmpty && componentsOfRestOfString.count >= 2 {
            /* Get the string after the matched substring*/
            let firstComponent = componentsOfRestOfString[1]
            
            let emailDomain = firstComponent.components(separatedBy: CharacterSet(charactersIn: " \n"))
            //print("emailDomain: \(emailDomain)")
            /* Check if the first is an email*/
            if emailDomain[0].contains("@") || attributedString.attributedSubstring(from: match.range(at: 0)).string.contains("@") {
                /* If the line or first word IS an email, don't apply italic styling */
                //print("returned\n\n")
                return
            }
        }
        
        /* Remove Markdown tags and apply italic styling */
        
        // deleting trailing markdown
        attributedString.deleteCharacters(in: match.range(at: 5))
        // formatting string (may alter the length)
        addAttributes(attributedString, range: match.range(at: 4))
        addAttributes(attributedString, range: match.range(at: 3))
        // deleting leading markdown
        attributedString.deleteCharacters(in: match.range(at: 2))
        //print("\n\n")
    }
}
