import UIKit

final class CheckersDayCell: DayCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        label.textColor = Checkers.black
        backgroundView?.backgroundColor = Checkers.white
        selectedBackgroundView?.clipsToBounds = true
        selectedBackgroundView?.backgroundColor = Checkers.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? Checkers.white : Checkers.black
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = bounds.size.width / 2.0
        selectedBackgroundView?.layer.cornerRadius = radius
    }
}
