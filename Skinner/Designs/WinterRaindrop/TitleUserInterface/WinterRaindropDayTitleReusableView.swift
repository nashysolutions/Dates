import UIKit

final class WinterRaindropDayTitleReusableView: DayTitleReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .blue
        label.font = WinterRaindrop.font2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
