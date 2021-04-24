import UIKit
import Calendar

final class HomeViewController: GradientViewController {
    
    private let sceneConfigurator = HomeViewControllerSceneConfigurator()
    
    let dateInputViewController = DateInputViewController()
    
    let desingsViewController = DesignsViewController()
    
    private var startDate: Date? {
        didSet {
            desingsViewController.startDate = startDate
        }
    }
    
    private var endDate: Date? {
        didSet {
            desingsViewController.endDate = endDate
        }
    }
    
    private let calendarControllerTransitioningDelegate = CalendarControllerTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateInputViewController.delegate = self
        addChild(dateInputViewController)
        sceneConfigurator.position(dateInputViewControllerRootView: dateInputViewController.view, inParent: view)
        dateInputViewController.didMove(toParent: self)
        
        desingsViewController.delegate = self
        addChild(desingsViewController)
        sceneConfigurator.position(designsViewControllerRootView: desingsViewController.view, inParent: view)
        desingsViewController.didMove(toParent: self)
        
        calendarControllerTransitioningDelegate.backgroundTapped = { [unowned self] in
            self.dismiss(animated: true)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: {
            self.desingsViewController.deselectCells()
            completion?()
        })
    }
}

extension HomeViewController: DateInputViewControllerDelegate {
    
    func startDateDidChange(_ date: Date?) {
        startDate = date
    }
    
    func endDateDidChange(_ date: Date?) {
        endDate = date
    }
}

extension HomeViewController: DesignsViewControllerDelegate {
    
    func designsViewController(_ controller: DesignsViewController, didSelectOption option: Option) {
        dateInputViewController.endEditing()
        guard let start = startDate else { preconditionFailure() }
        guard let end = endDate else { preconditionFailure() }
        do {
            let candidate = option.design.candidate
            let calendarView = try candidate.makeCalendarView(start, end)
            let calendarViewController = CalendarViewController(calendarView: calendarView)
            let navCon = UINavigationController(rootViewController: calendarViewController)
            navCon.navigationBar.tintColor = candidate.tintColor
            navCon.navigationBar.barTintColor = candidate.barTintColor
            navCon.modalPresentationStyle = .custom
            navCon.transitioningDelegate = calendarControllerTransitioningDelegate
            present(navCon, animated: true)
        } catch let error as Dates.Error {
            let errorDescription = error.errorDescription!
            let failureReason = error.failureReason!
            let recoverySuggestion = error.recoverySuggestion!
            fatalError(errorDescription + failureReason + recoverySuggestion)
        } catch let error as UserInterface.Error {
            let errorDescription = error.errorDescription!
            let failureReason = error.failureReason!
            let recoverySuggestion = error.recoverySuggestion!
            fatalError(errorDescription + failureReason + recoverySuggestion)
        } catch {
            fatalError("Unexpected error.")
        }
    }
}

private final class HomeViewControllerSceneConfigurator {
    
    var dateInputViewControllerRootView: UIView?
    
    func position(dateInputViewControllerRootView child: UIView, inParent parent: UIView) {
        parent.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        let safeAreaLayoutGuide = parent.safeAreaLayoutGuide
        child.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -20).isActive = true
        child.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        child.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        child.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 1/3.0).isActive = true
        dateInputViewControllerRootView = child
    }
    
    func position(designsViewControllerRootView child: UIView, inParent parent: UIView) {
        guard let dateInputViewControllerRootView = dateInputViewControllerRootView else {
            fatalError("Posiition dateInputViewControllerRootView first.")
        }
        parent.addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        let safeAreaLayoutGuide = parent.safeAreaLayoutGuide
        child.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        child.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        child.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        child.topAnchor.constraint(equalTo: dateInputViewControllerRootView.bottomAnchor).isActive = true
    }
}
