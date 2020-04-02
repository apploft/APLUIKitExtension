//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

@available(iOS 11.0, *)
public extension UIView {
    
    /**
     Swifty way of adding constraints.
     
     *Example 1*
     
     let newView = UIView()
     
     view.add(subView: newView)
     
     newView.pinEdges() // pins to safearea of superview
     
     *Example 2*
     
     let newView = UIView()
     
     view.add(subView: newView)
     
     constraintsForSecondLayout = view.pinEdges().setAddedConstraintsInactive().getAddedConstraints() // store for later use
     
     constraintsForInitialLayout = view.pin(height: 50).pin(width: 50).pin(on: .left).pin(on: .top).getAddedConstraints() // store for later use
     
     }
     */    
    @discardableResult func pin(on type1: NSLayoutConstraint.Attribute,
                                       view: UIView? = nil, on type2: NSLayoutConstraint.Attribute? = nil,
                                       constant: CGFloat = 0,
                                       priority: Float? = nil) -> UIView {
        guard let view = view ?? superview?.safeAreaLayoutGuide else {
            return self
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        let type2 = type2 ?? type1
        let constraint = NSLayoutConstraint(item: self, attribute: type1,
                                            relatedBy: .equal,
                                            toItem: view, attribute: type2,
                                            multiplier: 1, constant: constant)
        if let priority = priority {
            constraint.priority = UILayoutPriority(priority)
        }
        
        constraint.isActive = true
        
        addedConstraints.append(constraint)
        
        return self
    }
    
    @discardableResult func pinEdges(view: UIView? = nil) -> UIView {
        return pin(on: .top, view: view).pin(on: .bottom, view: view).pin(on: .left, view: view).pin(on: .right, view: view)
    }
    
    @discardableResult func pin(size: CGSize) -> UIView {
        return pin(width: size.width).pin(height: size.height)
    }
    
    @discardableResult func pinSides(view: UIView? = nil, padding: CGFloat) -> UIView {
        return pin(on: .left, view: view, constant: padding).pin(on: .right, view: view, constant: -padding)
    }
    
    @discardableResult func pinUpward(view: UIView? = nil) -> UIView {
        return pin(on: .top, view: view).pin(on: .left, view: view).pin(on: .right, view: view)
    }
    
    @discardableResult func pinDownward(view: UIView? = nil) -> UIView {
        return pin(on: .bottom, view: view).pin(on: .left, view: view).pin(on: .right, view: view)
    }
    
    @discardableResult func pinCenter(view: UIView? = nil) -> UIView {
        return pin(on: .centerX, view: view).pin(on: .centerY, view: view)
    }
    
    @discardableResult func pin(width: CGFloat) -> UIView {
        return pin(constant: width, attribute: .width, relatedBy: .equal)
    }
    
    @discardableResult func pin(greaterThanWidht width: CGFloat) -> UIView {
        return pin(constant: width, attribute: .width, relatedBy: .greaterThanOrEqual)
    }
    
    @discardableResult func pin(lessThanWidht width: CGFloat) -> UIView {
        return pin(constant: width, attribute: .width, relatedBy: .lessThanOrEqual)
    }
    
    @discardableResult func pin(height: CGFloat) -> UIView {
        return pin(constant: height, attribute: .height, relatedBy: .equal)
    }
    
    @discardableResult func pin(greaterThanHeight height: CGFloat) -> UIView {
        return pin(constant: height, attribute: .height, relatedBy: .greaterThanOrEqual)
    }
    
    @discardableResult func pin(lessThanHeight height: CGFloat) -> UIView {
        return pin(constant: height, attribute: .height, relatedBy: .lessThanOrEqual)
    }
    
    private func pin(constant: CGFloat,
                     attribute: NSLayoutConstraint.Attribute,
                     relatedBy: NSLayoutConstraint.Relation) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: relatedBy,
                                            toItem: nil, attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constant)
        constraint.isActive = true
        addedConstraints.append(constraint)
        return self
    }
    
    @discardableResult func setAddedConstraintsInactive() -> UIView {
        addedConstraints.forEach { $0.isActive = false }
        return self
    }
    
    @discardableResult func getAddedConstraints() -> [NSLayoutConstraint] {
        let addedConstraints = self.addedConstraints
        self.addedConstraints = []
        return addedConstraints
    }
    
}

private extension UIView {
    
    private struct AssociatedKeys {
        static var AddedConstraints = "APLiOSFrameworkExtensions.addedConstraints"
    }
    
    var addedConstraints: [NSLayoutConstraint] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.AddedConstraints) as? [NSLayoutConstraint] ?? []
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.AddedConstraints, newValue as [NSLayoutConstraint]?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
