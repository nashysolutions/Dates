import UIKit
import Dequeue

protocol DesignsViewControllerDelegate: AnyObject {
    func designsViewController(_ controller: DesignsViewController, didSelectOption option: Option)
}

final class DesignsViewController: UIViewController {
    
    weak var delegate: DesignsViewControllerDelegate?
    
    private let collectionView = DesignsCollectionView()
    
    var startDate: Date? {
        didSet {
            checkDates()
            collectionView.reloadData()
        }
    }
    
    var endDate: Date? {
        didSet {
            checkDates()
            collectionView.reloadData()
        }
    }
    
    private func checkDates() {
        if startDate == nil {
            options = []
        } else if endDate == nil {
            options = []
        } else if startDate!.compare(endDate!) != .orderedAscending {
            options = []
        } else {
            options = Option.all
        }
    }
    
    private var options: [Option] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func deselectCells() {
        for indexPath in collectionView.indexPathsForSelectedItems ?? [] {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}

extension DesignsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dequableCollectionView = (collectionView as? DequeueableCollectionView) else {
            preconditionFailure("Must be DequeableCollectionView.")
        }
        let cell: DesignCollectionViewCell = dequableCollectionView.dequeueCell(at: indexPath)
        let option = options[indexPath.item]
        let name = option.design.candidate.name
        let prefix = "Skin \(indexPath.item + 1): "
        cell.update(with: prefix + name)
        return cell
    }
    
    private static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return DesignsViewController.edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let value = (collectionView.frame.height / 2.0) - DesignsViewController.edgeInsets.left + DesignsViewController.edgeInsets.right
        let width = collectionView.frame.inset(by: DesignsViewController.edgeInsets).width
        return CGSize(width: width, height: value / 2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let option = options[indexPath.item]
        delegate?.designsViewController(self, didSelectOption: option)
    }
}
