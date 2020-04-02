//
//  Credits:
//  Radiant Tap Essentials
//    https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//
//    Uses: https://github.com/roberthein/TinyConstraints
import UIKit

public extension UIViewController {
    
    /// Closure Type which layouts a view inside another view.
    /// (view, parentView) -> Void
    typealias LayoutBlock = (UIView, UIView) -> Void
    
    /// Layouts a view controller's view inside a parentview and adds the view controller as the child of the calling view controller.
    /// - Parameter viewController: The view controller which will be layouted into the parentView
    ///     and which will be added as a childview controller to the calling view controller.
    ///     This parameter needs a strong refference.
    /// - Parameter parentView: The parent view into which the view controller's view is layouted.
    ///     Default: The view of the calling view controller.
    /// - Parameter layout: A closure of type LayoutBlock which sets and activates the constraints of the view controller's view and parentView.
    ///     Default: A closure to layout the viewController's view to fill the whole parentView.
    @available(iOS 9.0, *)
    func embed<T>(controller viewController: T, into parentView: UIView?, layout: LayoutBlock = {
        view, parentView in
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
        })
        
        where T: UIViewController {
            let container = parentView ?? self.view!
            
            self.addChild(viewController)
            container.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            layout(viewController.view, container)
            viewController.didMove(toParent: self)
    }
    
    /// Removes a view controller from its parent view controller by removing its view and its child relationship.
    /// - Parameter controller: The view controller which will be unembeded from it's parent view controller.
    /// If the view controller should be deallocated after unembeding it no strong refference should be hold, i
    func unembed(controller: UIViewController?) {
        guard let controller = controller else { return }
        
        controller.willMove(toParent: nil)
        if controller.isViewLoaded {
            controller.view.removeFromSuperview()
        }
        controller.removeFromParent()
    }
    
    /// Get a reference on the first child view controller.
    /// - Returns: The first child view controller.
    func child<T: UIViewController>() -> T? {
        return children.filter { $0 is T }.first as? T
    }
}
