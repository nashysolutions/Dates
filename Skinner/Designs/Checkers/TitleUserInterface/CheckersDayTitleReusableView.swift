import UIKit

final class CheckersDayTitleReusableView: DayTitleReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = Checkers.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
