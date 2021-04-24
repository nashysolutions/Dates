import Foundation

enum Design: CaseIterable {
    
    case summerSnowflake, winterRaindrop, checkers
    
    var candidate: DesignCandidate {
        switch self {
        case .summerSnowflake:
            return SummerSnowflake()
        case .winterRaindrop:
            return WinterRaindrop()
        case .checkers:
            return Checkers()
        }
    }
}
