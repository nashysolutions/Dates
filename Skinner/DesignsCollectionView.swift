import UIKit
import Dequeue

final class DesignsCollectionView: UICollectionView, DequeueableCollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        register(cellType: DesignCollectionViewCell.self, hasXib: false)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
