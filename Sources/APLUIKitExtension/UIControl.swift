//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public extension UIControl {

    /**
     Swifty way of adding actions to buttons. But make sure to avoid retain cycles.
     
        *Example*
     
        let button = UIButton()
     
        button.setAction {
            print("test")
        }
     
     - Parameter controlEvents: the control events to trigger action
     - Parameter action: the action to execute on control event(s)
     */
    @available(iOS 9.0, *)
    func setAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> Void) {
        removeTarget(nil, action: nil, for: .allEvents)
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }

}

private class ClosureSleeve {

    let closure: () -> Void
    
    init(attachTo object: AnyObject, closure: @escaping () -> Void) {
        self.closure = closure
        objc_setAssociatedObject(object, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }

    @objc func invoke() {
        closure()
    }
}
