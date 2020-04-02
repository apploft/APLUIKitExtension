//
//  Credits:
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

public protocol StoryboardLoadable {
	static var storyboardName: String { get }
	static var storyboardIdentifier: String { get }
}

public extension StoryboardLoadable where Self: UIViewController {

    ///Storyboard Name
    static var storyboardName: String {
		return String(describing: self)
	}

    ///Storyboard Identifier
    static var storyboardIdentifier: String {
		return String(describing: self)
	}
    
    /// Instantiates view controller from storyboard name.
    /// - Parameter name: Name of the storyboard which should be initiated.
    ///     Default: Nil.
    static func instantiate(fromStoryboardNamed name: String? = nil) -> Self {
		let storyB = name ?? self.storyboardName
		let storyboard = UIStoryboard(name: storyB, bundle: nil)
		return instantiate(fromStoryboard: storyboard)
	}
    
    /// Instantiates view controller from storyboard object
    /// - Parameter storyboard: UIStoryboard which is used to initiate view controller.
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> Self {
		let identifier = self.storyboardIdentifier
		guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
			fatalError("Failed to instantiate view controller with identifier=\(identifier) from storyboard \( storyboard )")
		}
		return viewController
	}
    
    /// Instantiates initial view controller from storyboard name.
    /// - Parameter name: Name of the storyboard which should be initiated.
    ///     Default: Nil.
    static func initial(fromStoryboardNamed name: String? = nil) -> Self {
		let storyB = name ?? self.storyboardName
		let storyboard = UIStoryboard(name: storyB, bundle: nil)
		return initial(fromStoryboard: storyboard)
    }
    
    /// Instantiates initial view controller from storyboard object
    /// - Parameter storyboard: UIStoryboard which is used to initiate initial view controller.
    static func initial(fromStoryboard storyboard: UIStoryboard) -> Self {
		guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
			fatalError("Failed to instantiate initial view controller from storyboard named \( storyboard )")
		}
		return viewController
	}
}

extension UINavigationController: StoryboardLoadable {}
extension UITabBarController: StoryboardLoadable {}
extension UISplitViewController: StoryboardLoadable {}
extension UIPageViewController: StoryboardLoadable {}
