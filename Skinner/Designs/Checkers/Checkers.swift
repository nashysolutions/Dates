import UIKit
import Calendar

struct Checkers: DesignCandidate {
    
    static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let grey = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    var name: String {
        return "Checkers Delight"
    }
    
    var dayTypes: [DayUserInterfaceCandidate] {
        return DayPosition.allCases.map { Checkers.userInterface(for: $0) }
    }
    
    var titleTypes: [TitleUserInterfaceCandidate] {
        return TitlePosition.allCases.map { Checkers.userInterface(for: $0) }
    }
    
    var tintColor: UIColor {
        return Checkers.grey
    }
    
    var barTintColor: UIColor {
        return Checkers.black
    }
    
    var backgroundColor: UIColor {
        return Checkers.white
    }
    
    private static func userInterface(for position: DayPosition) -> DayUserInterfaceCandidate {
        let userInterface: DayUserInterface.Type
        switch position {
        case .invisible:
            userInterface = InvisibleSpacerDayCell.self
        case .disabled:
            userInterface = CheckersDisabledDayCell.self
        case .spacer:
            userInterface = InvisibleSpacerDayCell.self
        case .normal:
            userInterface = CheckersDayCell.self
        }
        return DayUserInterfaceCandidate(position: position, view: userInterface)
    }
    
    private static func userInterface(for position: TitlePosition) -> TitleUserInterfaceCandidate {
        let userInterface: TitleUserInterface.Type
        switch position {
        case .day:
            userInterface = CheckersDayTitleReusableView.self
        case .month:
            userInterface = CheckersMonthTitleReusableView.self
        }
        return TitleUserInterfaceCandidate(position: position, view: userInterface)
    }
}
