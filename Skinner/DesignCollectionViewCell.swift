import UIKit
import Dequeue

final class DesignCollectionViewCell: UICollectionViewCell, DequeueableComponentIdentifiable {
    
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = green
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        
        titleLabel = label
        
        backgroundView = UIView(frame: bounds)
        selectedBackgroundView = UIView(frame: bounds)
        backgroundColor = blue
        selectedBackgroundView?.backgroundColor = brown
        clipsToBounds = true
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with name: String) {
        titleLabel.text = name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = bounds.width * 0.05
        layer.cornerRadius = radius
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? red : green
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.verticalSizeClass == .compact {
            titleLabel.font = font1
        } else {
            titleLabel.font = font2
        }
    }
}
