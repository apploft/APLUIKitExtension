//
//  File.swift
//  
//
//  Created by Ali Ebrahimi Pourasad on 02.04.20.
//

import UIKit

extension UIImage {
    
    /// Given a start and an end color create a gradient image
    /// - Parameter startColor: the start color of the gradient color
    /// - Parameter endColor: the end color of the gradient color
    /// - Returns: a gradient image
    static func gradientImage(startColor: UIColor, endColor: UIColor) -> UIImage {
        let gradientLayer = CAGradientLayer()
        let bounds = CGRect(x: 0, y: 0, width: 4.0, height: 44.0)
        
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
