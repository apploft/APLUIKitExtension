//
//    Credits:
//    Stefano Vettor
//    https://gist.github.com/freedom27/c709923b163e26405f62b799437243f4

import UIKit

extension CAShapeLayer {
    /// Draws a rounded rectangle around CGRect.
    /// - Parameter rect: The rect around which the rounded rectangle should be drawn.
    /// - Parameter color: The color of the newly drawn rectangle.
    /// - Parameter isFilled: A boolean value indicating if the rectangle should be filled with the color, or stay white.
    func drawRoundedRect(_ rect: CGRect, _ color: UIColor, _ isFilled: Bool) {
        fillColor = isFilled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
}

private var badgeShapeLayerAssociationKey: UInt8 = 0
private var badgeTextLayerAssociationKey: UInt8 = 1

public extension UIBarButtonItem {
    private var badgeShapeLayer: CAShapeLayer? {
        if let badge: AnyObject = objc_getAssociatedObject(self, &badgeShapeLayerAssociationKey) as AnyObject? {
            return badge as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    private var badgeTextLayer: CATextLayer? {
        if let badge: AnyObject = objc_getAssociatedObject(self, &badgeTextLayerAssociationKey) as AnyObject? {
            return badge as? CATextLayer
        } else {
            return nil
        }
    }
    
    /// Remove all layers from the layer hierarchy
    @objc func removeBadge() {
        badgeShapeLayer?.removeFromSuperlayer()
    }
    
    /// Sets customizable badges of an bar button item.
    /// - Parameter text: The text inside the badge. Default: empty string.
    /// - Parameter badgeSize: The size of the badge. Default: 20 x 20
    /// - Parameter badgeOrigin: The origin of the badge. Default: zero.
    /// - Parameter color: The color of the badge. Default: red.
    /// - Parameter isFilled: Boolean indicating if the badge should be filled out. Default: true.
    /// - Parameter fontSize: The font size of the badge's text. Default: 12.
    @available(*, deprecated, message: "Use the new setBadge function instead")
    @objc func setBadge(text: String = "",
                        badgeSize: CGSize = CGSize(width: 20.0, height: 20.0),
                        badgeOrigin: CGPoint = CGPoint.zero,
                        color: UIColor = UIColor.red,
                        isFilled: Bool = true,
                        fontSize: CGFloat = 12) {
        self.removeBadge()
        if text.isEmpty {
            return
        }
        
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        // Create badge layer
        let badgeShapeLayer = CAShapeLayer()
        let badgeFrame = CGRect(origin: CGPoint(x: badgeOrigin.x, y: -badgeOrigin.y), size: badgeSize)
        badgeShapeLayer.drawRoundedRect(badgeFrame, color, isFilled)
        view.layer.addSublayer(badgeShapeLayer)
        
        // Create label layer
        let labelTextLayer = CATextLayer()
        labelTextLayer.string = text
        labelTextLayer.alignmentMode = CATextLayerAlignmentMode.center
        labelTextLayer.font = font
        labelTextLayer.fontSize = font.pointSize
        labelTextLayer.foregroundColor = isFilled ? UIColor.white.cgColor : color.cgColor
        labelTextLayer.backgroundColor = UIColor.clear.cgColor
        labelTextLayer.contentsScale = UIScreen.main.scale
        
        labelTextLayer.frame = CGRect(origin: CGPoint(x: badgeOrigin.x + (badgeSize.width-textSize.width)*0.5,
                                                      y: -(badgeOrigin.y - (badgeSize.height-textSize.height)*0.5)),
                                      size: textSize)
        
        badgeShapeLayer.addSublayer(labelTextLayer)
        
        // Save as UIBarButtonItem properties
        objc_setAssociatedObject(self, &badgeShapeLayerAssociationKey, badgeShapeLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &badgeTextLayerAssociationKey, labelTextLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /// Sets a customizable badge with border of an bar button item.
    /// The borderWidth will increase the size of the badge. A badgeSize of 20 x 20 plus a borderWidth of 2
    /// will create a badge of the size 22 x 22.
    /// - Parameter text: The text inside the badge. Default: empty string.
    /// - Parameter badgeSize: The size of the badge. Default: 20 x 20
    /// - Parameter badgeOrigin: The origin of the badge. Default: zero.
    /// - Parameter backgroundColor: The color of the badge. Default: red.
    /// - Parameter font: The font of the badge's text. Default: systemFont size 12.
    /// - Parameter textColor: The font size of the badge's text. Default: black.
    /// - Parameter borderWidth: The border width of the badge. Default: 0.
    /// - Parameter borderColor: The border color of the badge. Default: UIColor.clear.
    @objc func setBadge(text: String = "",
                        badgeSize: CGSize = CGSize(width: 20.0, height: 20.0),
                        badgeOrigin: CGPoint = CGPoint.zero,
                        backgroundColor: UIColor = UIColor.red,
                        font: UIFont = UIFont.systemFont(ofSize: 12),
                        textColor: UIColor = UIColor.black,
                        borderWidth: CGFloat = 0.0,
                        borderColor: UIColor = UIColor.clear) {
        self.removeBadge()
        guard text.isEmpty else {
            return
        }

        guard let view = self.value(forKey: "view") as? UIView else { return }

        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])

        // Create badge layer
        let badgeSizeWithBorder = CGSize(width: badgeSize.width + borderWidth, height: badgeSize.height + borderWidth)
        let badgeFrame = CGRect(origin: CGPoint(x: badgeOrigin.x, y: -badgeOrigin.y), size: badgeSizeWithBorder)

        let badgeShapeLayer = createBadgeShapeLayer(for: badgeFrame,
                                                    cornerRadius: badgeSizeWithBorder.height / 2,
                                                    borderColor: borderColor,
                                                    fillColor: backgroundColor,
                                                    lineWidth: borderWidth)
        view.layer.addSublayer(badgeShapeLayer)

        // Create label layer
        let labelTextLayer = createLabelTextLayer(with: text,
                                                  alignment: .center,
                                                  font: font,
                                                  textColor: textColor,
                                                  backgroundColor: backgroundColor)

        labelTextLayer.frame = CGRect(origin: CGPoint(x: badgeOrigin.x + (badgeSizeWithBorder.width-textSize.width)*0.5,
                                                      y: -(badgeOrigin.y - (badgeSizeWithBorder.height-textSize.height)*0.5)),
                                      size: textSize)

        badgeShapeLayer.addSublayer(labelTextLayer)

        // Save as UIBarButtonItem properties
        objc_setAssociatedObject(self, &badgeShapeLayerAssociationKey, badgeShapeLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &badgeTextLayerAssociationKey, labelTextLayer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    ///Toggles visibility of badge
    /// - Parameter isHidden: Boolean indicating if the badges should be hidden.
    @objc func isHidden(_ isHidden: Bool) {
        badgeShapeLayer?.isHidden = isHidden
    }
    
    ///Updates the text inside the Badge
    /// - Parameter text: The text which sould be the new text inside the badge.
    @objc func updateBadge(text: String = "") {
        if let badgeShapeLayerPath = badgeShapeLayer?.path, let badgeTextLayer = badgeTextLayer, let font = badgeTextLayer.font {
            let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
            let badgeOrigin: CGPoint = badgeShapeLayerPath.boundingBox.origin
            let badgeSize: CGSize = badgeShapeLayerPath.boundingBox.size
            badgeTextLayer.string = text
            badgeTextLayer.frame = CGRect(origin: CGPoint(x: badgeOrigin.x + (badgeSize.width-textSize.width) * 0.5,
                                                          y: badgeTextLayer.frame.origin.y),
                                          size: textSize)
        }
    }

    //MARK:- Helpers

    private func createBadgeShapeLayer(for badgeFrame: CGRect,
                                       cornerRadius: CGFloat,
                                       borderColor: UIColor,
                                       fillColor: UIColor,
                                       lineWidth: CGFloat) -> CAShapeLayer {
        let badgeShapeLayer = CAShapeLayer()
        badgeShapeLayer.strokeColor = borderColor.cgColor
        badgeShapeLayer.fillColor = fillColor.cgColor
        badgeShapeLayer.lineWidth = lineWidth
        badgeShapeLayer.path = UIBezierPath(roundedRect: badgeFrame, cornerRadius: cornerRadius).cgPath

        return badgeShapeLayer
    }

    private func createLabelTextLayer(with text: String,
                                      alignment: CATextLayerAlignmentMode,
                                      font: UIFont,
                                      textColor: UIColor,
                                      backgroundColor: UIColor) -> CATextLayer {
        let labelTextLayer = CATextLayer()
        labelTextLayer.string = text
        labelTextLayer.alignmentMode = alignment
        labelTextLayer.font = font
        labelTextLayer.fontSize = font.pointSize
        labelTextLayer.foregroundColor = textColor.cgColor
        labelTextLayer.backgroundColor = UIColor.clear.cgColor
        labelTextLayer.contentsScale = UIScreen.main.scale

        return labelTextLayer
    }
}
