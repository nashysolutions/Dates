import UIKit

extension UIView {
  
  public func shake(makeOpaque: Bool = false) {
    layer.add(shakeAnimation, forKey: "shake")
    if makeOpaque {
      layer.add(alphaAnimation, forKey: "alpha")
    }
  }
  
  private var shakeAnimation: CAKeyframeAnimation {
    let animation = CAKeyframeAnimation(keyPath: "transform")
    animation.values = [
      NSValue(caTransform3D: CATransform3DMakeTranslation(-10, 0, 0)),
      NSValue(caTransform3D: CATransform3DMakeTranslation(10, 0, 0))
    ]
    animation.autoreverses = true
    animation.repeatCount = 2
    animation.duration = 0.07
    return animation
  }
  
  private var alphaAnimation: CABasicAnimation {
    let alphaAnimation = CABasicAnimation(keyPath: "opacity")
    alphaAnimation.fromValue = NSNumber(integerLiteral: 0)
    alphaAnimation.fillMode = CAMediaTimingFillMode.forwards
    return alphaAnimation
  }
  
}
