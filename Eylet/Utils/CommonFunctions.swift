import Foundation


func cutBeforeCharacter(snippet: String, string: String) -> String {
    if let range = snippet.range(of: string) {
               let beginningSnippet = snippet[range.upperBound...]
               return String(beginningSnippet)
           }
    
    return "error in cutBeforeCharacters"
}

func cutAfterCharacter(snippet: String, string: String) -> String {
    if let index = snippet.range(of: string)?.lowerBound {
        let substring = snippet[..<index]                 // "ora"
        let string = String(substring)
        return string
    }
    return "error in cutAfterCharacters"
}
