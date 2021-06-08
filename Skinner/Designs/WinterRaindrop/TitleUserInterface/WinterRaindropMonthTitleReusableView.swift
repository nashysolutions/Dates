import UIKit

class WinterRaindropMonthTitleReusableView: MonthTitleReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .blue
        label.font = WinterRaindrop.font3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
