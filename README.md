# APLUIKitExtension

This package provides extensions and subclasses to commonly used `UIKit` Classes, like `UIColor` and `UIViewController`.
Everything is written in Swift, documented and tested.
This package is restricted to the iOS platfrom.

## Table of Contents

- [Overview of Classes and Functionalities](#overviewOfClassesAndFunctionalities)
- [Installation](#installation)
  - [Swift Package](#swiftpackage)
- [Usage](#usage)
- [License](#license)

## Overview of Classes and Functionalities

In the following an overview of all subclasses/extended classes and their functionalities:

#### AutoMaxLayoutWidthLabel (subclass of `UILabel`)

- Automaticly scales the label to its maximal needed size based on its content view.

#### DefaultTabBarControllerDelegate (subclass of `UITabBarControllerDelegate`)

- Perform an action in a view controller if the corresponding tab bar item is selected again.

#### NibLoadable (extension for `UIView`)

- Generates a `nib`, `nibName` and `nibInstance` of a view. Mainly usefull for `UITableViewCell` and `UICollectionViewCell`.

#### ReusableView (extension for `UIView`)

- Generate a resuable identifier.

#### StoryboardLoadable (extension for `UIViewController`)

- Generate `storyboardName` and `storyboardIdentifier`.
- Methods to instantiate a `UIViewController` with either a `storyboard name` or a `storyboard` object.
- Methods to instantiate the initial view controller from either a `storyboard name` or a `storyboard` object.

#### UIBarButtonBadge Extention

- Create and update a Badge.

#### UIButton Extension

- Set the background to a color, a gradient color, or a rounded image.

#### UICollectionView Extension

- Given a view determine the index path of the corresponding collection view cell.

#### UIColor Extension

- Blend colors together
- lighter color
- darker color
- adjust color
- generate image from color
- generate hexstring

#### UIControl Extension

- Enable adding actions to buttons the swity way.

#### UIDevice Extension

- Generate the model identifier of the used device.

#### UIImage Extension

- Generate a gradient image.

#### UIResponder Extension

- Get the current first responder.

#### UITableView Extension

- Given a view determine the index path of the corresponding table view cell.

#### UIView Extension

- Add Swifty way of adding constrains.
- Add inspectable elements for interface builder:
  - cornerRadius
  - cornerIsCircle
  - borderWidth
  - borderColor
  - shadowOffset
  - shadowRadius
  - shadowOpacity
  - layerShadowColor

#### UIViewController Extension

- Determine the top visible view controller.
- Create different types of `UIAlertController` with ease.
- Manage back button behaviour in navigation bar.
- Wrapper to embed and unembed view controller into each other.

## Installation

### [Swift Package](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md#supportedplatform)

Just integrate the APLUIKitExtension via Xcode 11 ([tutorial](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)).

## Usage

After importing `APLUIKitExtension` all classes, extensions and documentation can be accessed the default way.

An example of using the method `darker()` of the `UIColor` extension:

```swift
import APLUIKitExtension

let redColor = UIColor.red
let darkerRedColor = redColor.darker()
```

An example of using the class 'AutoMaxLayoutWidthLabel':

```swift
import APLUIKitExtension

let label = AutoMaxLayoutWidthLabel(frame: .zero)
```

## License

**APLUIKitExtension** is created by apploft on 02.04.2020.
Copyright © 2019 apploft GmbH￼￼
MIT License · http://choosealicense.com/licenses/mit/
