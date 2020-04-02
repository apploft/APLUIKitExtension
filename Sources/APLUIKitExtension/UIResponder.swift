//
// Credits:
// https://stackoverflow.com/questions/1823317/get-the-current-first-responder-without-using-a-private-api/37492338#37492338
//

import UIKit

extension UIResponder {
    private weak static var currentFirstResponder: UIResponder? = nil

    public static var current: UIResponder? {
        UIResponder.currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return UIResponder.currentFirstResponder
    }

    @objc internal func findFirstResponder(sender: AnyObject) {
        UIResponder.currentFirstResponder = self
    }
}
