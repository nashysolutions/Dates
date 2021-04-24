import UIKit

final class WinterRaindropSpacerDayCell: SpacerDayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.font = WinterRaindrop.font1
        label.textColor = .lightGray
        backgroundView?.backgroundColor = SummerSnowflake.shade
        selectedBackgroundView?.backgroundColor = brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? red : green
        }
    }
}
