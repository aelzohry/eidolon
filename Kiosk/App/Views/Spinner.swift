import UIKit

class Spinner: UIView {
    var spinner:UIView!
    let rotationDuration = 0.9;

    func createSpinner() -> UIView {
        let view = UIView(frame: CGRectMake(0, 0, 20, 5))
        view.backgroundColor = .blackColor()
        return view
    }

    override func awakeFromNib() {
        spinner = createSpinner()
        addSubview(spinner)
        backgroundColor = .clearColor()
        animateN(Float.infinity)
    }

    override func layoutSubviews() {
        // .center uses frame
        spinner.center = CGPointMake( CGRectGetWidth(bounds) / 2, CGRectGetHeight(bounds) / 2)
    }

    func animateN(times: Float) {
        let transformOffset = -1.01 * M_PI
        let transform = CATransform3DMakeRotation( CGFloat(transformOffset), 0, 0, 1);
        let rotationAnimation = CABasicAnimation(keyPath:"transform");

        rotationAnimation.toValue = NSValue(CATransform3D:transform)
        rotationAnimation.duration = rotationDuration;
        rotationAnimation.cumulative = true;
        rotationAnimation.repeatCount = Float(times);
        layer.addAnimation(rotationAnimation, forKey:"spin");
    }

    func animate(animate: Bool) {
        let isAnimating = layer.animationForKey("spin") != nil
        if (isAnimating && !animate) {
            layer.removeAllAnimations()

        } else if (!isAnimating && animate) {
            self.animateN(Float.infinity)
        }
    }

    func stopAnimating() {
        layer.removeAllAnimations()
        animateN(1)
    }
}
