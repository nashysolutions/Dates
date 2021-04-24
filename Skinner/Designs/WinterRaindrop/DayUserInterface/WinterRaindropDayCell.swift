import UIKit

final class WinterRaindropDayCell: DayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.font = WinterRaindrop.font1
        label.textColor = .blue
        backgroundView?.backgroundColor = WinterRaindrop.white
        selectedBackgroundView?.backgroundColor = brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? WinterRaindrop.white : .blue
        }
    }
}
