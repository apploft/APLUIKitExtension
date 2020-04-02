//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public extension UIButton {
    
    /// Set a state-dependent background color for a button. UIButton by default
    /// can only be configured with a state-dependent background image.
    /// - Parameter color: the color to set
    /// - Parameter forState: the state to set the color for
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }

    /// Set a state-dependent background color for a button. UIButton by default
    /// can only be configured with a state-dependent background image.
    /// - Parameter color: the color to set
    /// - Parameter forState: the state to set the color for
    func setRoundedRectBackgroundImage(color: UIColor, height: CGFloat, cornerRadius: CGFloat, forState: UIControl.State) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: height, height: height), false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let rect = CGRect(x: 0, y: 0, width: height, height: height)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        
        context.addPath(clipPath)
        context.setFillColor(color.cgColor)
        context.closePath()
        context.fillPath()
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let inset: CGFloat = height/2-1
        let image = colorImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset), resizingMode: .stretch)
        
        self.setBackgroundImage(image, for: forState)
    }
    
    /// Set a state-dependent gradient background color for a button.
    /// - Parameter startColor: the start color of the gradient color
    /// - Parameter endColor: the end color of the gradient color
    /// - Parameter forState: the state to set the color for
    func setGradientBackgroundColor(startColor: UIColor, endColor: UIColor, forState: UIControl.State) {
        let gradientImage = self.gradientImage(startColor: startColor, endColor: endColor)
        
        setBackgroundImage(gradientImage, for: forState)
    }
    
    /// Given a start and an end color create a gradient image
    /// - Parameter startColor: the start color of the gradient color
    /// - Parameter endColor: the end color of the gradient color
    /// - Returns: a gradient image
    func gradientImage(startColor: UIColor, endColor: UIColor) -> UIImage {
        let gradientLayer = CAGradientLayer()
        let bounds = CGRect(x: 0, y: 0, width: 1.0, height: 44.0)
        
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.bounds = bounds
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, true, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        gradientLayer.render(in: context!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}
