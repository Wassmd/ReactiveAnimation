import UIKit

protocol Animatable {
    func animate(view: UIView)
    func resetToOriginalState(view: UIView)
}

extension Animatable {
    func animate(view: UIView) {
        let timingParameter = UICubicTimingParameters(controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 0.2, y: 1))
        let animate = UIViewPropertyAnimator.init(duration: 0.15, timingParameters: timingParameter)
        animate.addAnimations {
            view.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
        
        animate.startAnimation()
    }
    
    func resetToOriginalState(view: UIView) {
        view.transform = .identity
    }
}
