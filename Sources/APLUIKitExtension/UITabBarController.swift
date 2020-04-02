//
// Credits:
// http://stackoverflow.com/questions/27008737/how-do-i-hide-show-tabbar-when-tapped-using-swift-in-ios8/27072876#27072876
//

import UIKit

@available(iOS 11.0, *)
public extension UITabBarController {
    /// Starting with iOS 11 it is possible to show or hide the tabbar
    /// of a tabbar controller
    /// - Parameter visible: true to show, false to hide the tabbar
    /// - Parameter animated: whether or not to animate the change
    func setTabBarVisible(_ visible: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        // bail if the current state matches the desired state
        guard isTabBarVisible != visible else { return }
        
        // get a frame calculation ready
        let offsetY = tabBar.frame.size.height
        
        let actionBlock = {
            self.view.frame.size.height += (visible ? -offsetY : offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
        
        let completionBlock: (Bool) -> Void = { finished in
            if finished {
                self.tabBar.isHidden = !visible
            }
            completion?()
        }
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: actionBlock, completion: completionBlock)
        } else {
            UIView.performWithoutAnimation(actionBlock)
            completionBlock(true)
        }
    }
    
    /// Determine whether or not the tabbar of a tabbar controller is visible
    var isTabBarVisible: Bool {
        return view.frame.size.height == view.superview?.frame.size.height
    }
    
}
