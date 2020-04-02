//
// Created by apploft on 02.04.2020.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public extension UICollectionView {

    /// Given a view determine the index path of the corresponding
    /// table view cell.
    /// - Parameter view: the view contained in any of the cells
    /// - Returns: the corresponding index path or nil
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let point = view.convert(CGPoint.zero, to: self)
        return indexPathForItem(at: point)
    }
}
