import UIKit

final class CalendarControllerAnimator: NSObject {
    
    var isPresentation: Bool = false
}

extension CalendarControllerAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let detailController = transitionContext.viewController(forKey: isPresentation ? .to : .from)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(detailController.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: detailController)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        detailController.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 300,
                       initialSpringVelocity: 5,
                       options: .beginFromCurrentState,
                       animations: {
                        detailController.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}

class PresentationController: UIPresentationController {
    
    private let dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        view.alpha = 0.0
        return view
    }()

    var backgroundTapped: (() -> Void)?
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        backgroundTapped?()
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView!.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView!.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView!.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView!.trailingAnchor)
            ])
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1.0
            })
        } else {
            dimmingView.alpha = 1.0
        }
    }
    
    override var adaptivePresentationStyle: UIModalPresentationStyle {
        return .overFullScreen
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            })
        } else {
            dimmingView.alpha = 0
        }
    }
    
    var dismissalCompletion: (() -> Void)?
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dismissalCompletion?()
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

final class CalendarPresentationController: PresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame = containerView!.frame
        let childSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        frame.origin.x += (frame.size.width - childSize.width) / 2.0
        frame.origin.y += (frame.size.height - childSize.height) / 2.0
        frame.size = childSize
        return frame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width*0.90, height: parentSize.height*0.70)
    }
    
}

final class CalendarControllerTransitioningDelegate: NSObject {
    fileprivate let animator = CalendarControllerAnimator()
    var backgroundTapped: (() -> Void)?
}

extension CalendarControllerTransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = CalendarPresentationController(presentedViewController: presented, presenting: presenting)
        controller.backgroundTapped = backgroundTapped
        return controller
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresentation = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresentation = false
        return animator
    }
    
}
