import UIKit
import Calendar

struct WinterRaindrop: DesignCandidate {
    
    static let font1 = UIFont.systemFont(ofSize: (UIScreen.main.bounds.width == 320) ? 18 : 20)
    static let font2 = UIFont.systemFont(ofSize: (UIScreen.main.bounds.width == 320) ? 14 : 16)
    static let font3 = UIFont.systemFont(ofSize: (UIScreen.main.bounds.width == 320) ? 24 : 30)
    
    static let almostWhite = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
    static let white = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var name: String {
        return "Winter Raindrop"
    }
    
    var dayTypes: [DayUserInterfaceCandidate] {
        return DayPosition.allCases.map { WinterRaindrop.userInterface(for: $0) }
    }
    
    var titleTypes: [TitleUserInterfaceCandidate] {
        return TitlePosition.allCases.map { WinterRaindrop.userInterface(for: $0) }
    }
    
    var tintColor: UIColor {
        return .white
    }
    
    var barTintColor: UIColor {
        return .blue
    }
    
    var backgroundColor: UIColor {
        return WinterRaindrop.almostWhite
    }
    
    private static func userInterface(for position: DayPosition) -> DayUserInterfaceCandidate {
        let userInterface: DayUserInterface.Type
        switch position {
        case .invisible:
            userInterface = InvisibleSpacerDayCell.self
        case .disabled:
            userInterface = WinterRaindropDisabledDayCell.self
        case .spacer:
            userInterface = WinterRaindropSpacerDayCell.self
        case .normal:
            userInterface = WinterRaindropDayCell.self
        }
        return DayUserInterfaceCandidate(position: position, view: userInterface)
    }
    
    private static func userInterface(for position: TitlePosition) -> TitleUserInterfaceCandidate {
        let userInterface: TitleUserInterface.Type
        switch position {
        case .day:
            userInterface = WinterRaindropDayTitleReusableView.self
        case .month:
            userInterface = WinterRaindropMonthTitleReusableView.self
        }
        return TitleUserInterfaceCandidate(position: position, view: userInterface)
    }
}
