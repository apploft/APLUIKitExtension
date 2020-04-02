//
// Created by apploft on 27.01.2019.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

/// This Subclass of UILabel always automaticly scales the label to it's maximal needed size based on its content view.
public class AutoMaxLayoutWidthLabel: UILabel {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)

        setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if preferredMaxLayoutWidth != frame.size.width {
            preferredMaxLayoutWidth = frame.size.width
            setNeedsUpdateConstraints()
        }
    }

    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height += 1.0
        return size
    }
}
