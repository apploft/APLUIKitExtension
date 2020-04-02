//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public extension UIDevice {
    
    /// Gets the  model identifier of the used  device
    /// - Returns: Model identifier if used device
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { (identifier: String, element: (label: String?, value: Any)) -> String in
            guard let version = valueToVersion(element.value) else { return identifier }
            return identifier + version
        }
    }
    
    private func valueToVersion(_ value: Any) -> String? {
        guard let value = value as? Int8, value != 0 else { return nil }
        return String(UnicodeScalar(UInt8(value)))
    }
}
