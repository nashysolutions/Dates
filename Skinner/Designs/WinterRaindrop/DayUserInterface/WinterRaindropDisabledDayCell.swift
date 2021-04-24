import UIKit

final class WinterRaindropDisabledDayCell: DisabledDayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.font = WinterRaindrop.font1
        label.textColor = green
        backgroundView = PathView(type: .day)
        selectedBackgroundView?.backgroundColor = brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
