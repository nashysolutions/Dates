import UIKit

protocol DateInputViewControllerDelegate: AnyObject {
    func startDateDidChange(_ date: Date?)
    func endDateDidChange(_ date: Date?)
}

final class DateInputViewController: UIViewController {
    
    private class TextField: UITextField {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            borderStyle = .roundedRect
            textAlignment = .center
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    private lazy var startDateTextField: TextField = {
        let view = TextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "startDateTextField"
        return view
    }()
    
    private lazy var endDateTextField: TextField = {
        let view = TextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "endDateTextField"
        return view
    }()
    
    weak var delegate: DateInputViewControllerDelegate?
    
    private let stackView = UIStackView()
    
    var selectedStartDate: Date? {
        didSet {
            delegate?.startDateDidChange(selectedStartDate)
        }
    }
    
    var selectedEndDate: Date? {
        didSet {
            delegate?.endDateDidChange(selectedEndDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if view.traitCollection.verticalSizeClass == .compact ||
            view.traitCollection.verticalSizeClass == .unspecified {
            stackView.axis = .horizontal
            NSLayoutConstraint.activate(stackViewVerticallyCompactConstraints)
        } else {
            stackView.axis = .vertical
            NSLayoutConstraint.activate(stackViewVerticallyNotCompactConstraints)
        }
        
        startDatePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        startDateTextField.inputView = startDatePicker
        
        endDatePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        endDateTextField.inputView = endDatePicker
        
        stackView.insertArrangedSubview(endDateTextField, at: 0)
        stackView.insertArrangedSubview(startDateTextField, at: 0)
        
        let startDate = Date()
        startDatePicker.date = startDate
        startDateChanged(startDatePicker.date)
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
        guard var month = components.month else { preconditionFailure() }
        month += 1
        components.month = month
        guard let endDate = Calendar.current.date(from: components) else { preconditionFailure() }
        endDatePicker.date = endDate
        endDateChanged(endDatePicker.date)
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        if sender === startDatePicker {
            startDateChanged(sender.date)
        } else if sender === endDatePicker {
            endDateChanged(sender.date)
        } else {
            fatalError()
        }
    }
    
    private func startDateChanged(_ date: Date) {
        let string = dateFormatter.string(from: date)
        guard let formattedDate = dateFormatter.date(from: string) else { preconditionFailure() }
        selectedStartDate = formattedDate
        guard let selectedStartDate = selectedStartDate else { preconditionFailure() }
        startDateTextField.text = dateFormatter.string(from: selectedStartDate)
    }
    
    private func endDateChanged(_ date: Date) {
        let string = dateFormatter.string(from: date)
        guard let selectedEndDate = dateFormatter.date(from: string) else { preconditionFailure() }
        self.selectedEndDate = selectedEndDate
        endDateTextField.text = dateFormatter.string(from: selectedEndDate)
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        if newCollection.verticalSizeClass == .compact {
            NSLayoutConstraint.deactivate(stackViewVerticallyNotCompactConstraints)
            NSLayoutConstraint.activate(stackViewVerticallyCompactConstraints)
        } else {
            NSLayoutConstraint.deactivate(stackViewVerticallyCompactConstraints)
            NSLayoutConstraint.activate(stackViewVerticallyNotCompactConstraints)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if view.traitCollection.verticalSizeClass == .compact {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
    
    private lazy var stackViewVerticallyCompactConstraints: [NSLayoutConstraint] = {
        var collector = [NSLayoutConstraint]()
        var constraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        constraint.priority = .defaultHigh
        collector.append(constraint)
        constraint = stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        collector.append(constraint)
        collector.append(contentsOf: [
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        return collector
    }()
    
    private lazy var stackViewVerticallyNotCompactConstraints: [NSLayoutConstraint] = {
        return [
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
    }()
    
    private lazy var startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        return picker
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
