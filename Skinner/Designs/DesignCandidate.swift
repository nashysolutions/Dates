import UIKit
import Calendar

protocol DesignCandidate {
    var name: String { get }
    var dayTypes: [DayUserInterfaceCandidate] { get }
    var titleTypes: [TitleUserInterfaceCandidate] { get }
    var tintColor: UIColor { get }
    var barTintColor: UIColor { get }
    var backgroundColor: UIColor { get }
}

extension DesignCandidate {
    
    func makeCalendarView(_ start: Date, _ end: Date) throws -> PagingGridView {
        let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)
        let calendarView = try PagingGridView(dates: start...end, userInterface: userInterface)
        calendarView.backgroundColor = backgroundColor
        return calendarView
    }
}
