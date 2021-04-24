import UIKit

final class CheckersDisabledDayCell: DisabledDayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.textColor = Checkers.grey
        backgroundView?.backgroundColor = Checkers.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
