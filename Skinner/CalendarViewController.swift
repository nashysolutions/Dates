import UIKit
import Calendar

final class CalendarViewController: UIViewController {
    
    private let calendarView: PagingGridView
    
    init(calendarView: PagingGridView) {
        self.calendarView = calendarView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = makePreviousButton()
        navigationItem.rightBarButtonItem = makeNextButton()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
        
    private func makePreviousButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(previousButtonPressed))
    }
    
    @objc private func previousButtonPressed(_ sender: UIBarButtonItem) {
        calendarView.scrollToPreviousPage(animated: true)
    }
    
    private func makeNextButton() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
    }
    
    @objc private func nextButtonPressed(_ sender: UIBarButtonItem) {
        calendarView.scrollToNextPage(animated: true)
    }
}
