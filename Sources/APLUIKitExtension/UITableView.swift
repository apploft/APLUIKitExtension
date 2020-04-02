//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public extension UITableView {
    
    /// Given a view determine the index path of the corresponding
    /// table view cell.
    /// - Parameter view: the view contained in any of the cells
    /// - Returns: the corresponding index path or nil
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let point = view.convert(CGPoint.zero, to: self)
        return indexPathForRow(at: point)
    }
}
