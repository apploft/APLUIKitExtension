//
// Credits:
// https://gist.github.com/HamGuy/a099058e674b573ffe433132f7b5651e
//

import UIKit

@objc protocol NavigationControllerBackButtonDelegate {
    
    /// Method to handle view controller's navigaiton bar 'Back' button click.
    /// - Returns: Boolean Indicator deciding whether the view controller should pop, when it's navigaiton bar back button is pressed.
    func shouldPopOnBackButtonPress() -> Bool
}

extension UIViewController: NavigationControllerBackButtonDelegate {
    
    /// Override this method in derived class to handle navigaiton bar 'Back' button click. If not overritten the view controller
    ///  defaultly pop's when the back button is pressed.
    /// - Returns: Boolean Indicator deciding whether the view controller should pop, when it's navigaiton bar back button is pressed.
    func shouldPopOnBackButtonPress() -> Bool {
        return true
    }
}

extension UINavigationController: UINavigationBarDelegate {
    
    /// Indicating wether the navigatoin bar top item can be popped. If the top item can be popped, it will also be popped.
    /// - Parameter navigationBar: Navigation bar that the item can be popped from.
    /// - Parameter item: Navigation item that can being popped.
    /// - Returns: A Bool indicating if the item can be popped
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        // Prevents from a synchronization issue of popping too many navigation items
        // and not enough view controllers or viceversa from unusual tapping
        if viewControllers.count < navigationBar.items!.count {
            return true
        }
        
        // Check if we have a top view controller that wants to respond to being popped.
        let shouldPop = self.topViewController?.shouldPopOnBackButtonPress() ?? true
        
        if (shouldPop) {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            // Prevent the back button from staying in an disabled state
            for view in navigationBar.subviews {
                if view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: {
                        view.alpha = 1.0
                    })
                }
            }
        }
        return false
    }
}
