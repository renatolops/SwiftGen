//: #### Other pages
//:
//: * [Demo for `swiftgen strings`](Strings-Demo)
//: * [Demo for `swiftgen images`](Images-Demo)
//: * Demo for `swiftgen storyboards`
//: * [Demo for `swiftgen colors`](Colors-Demo)
//: * [Demo for `swiftgen fonts`](Fonts-Demo)

class CreateAccViewController: UIViewController {}

//: #### Example of code generated by swiftgen-storyboard

// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
    static var storyboardName: String { get }
}

extension StoryboardSceneType {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }

    static func initialViewController() -> UIViewController {
        guard let vc = storyboard().instantiateInitialViewController() else {
            fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
        }
        return vc
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
    func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

struct StoryboardScene {
    enum Wizard: String, StoryboardSceneType {
        static let storyboardName = "Wizard"

        static func initialViewController() -> CreateAccViewController {
            guard let vc = storyboard().instantiateInitialViewController() as? CreateAccViewController else {
                fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
            }
            return vc
        }

        case acceptCGUScene = "Accept-CGU"
        static func instantiateAcceptCGU() -> UIViewController {
            return StoryboardScene.Wizard.acceptCGUScene.viewController()
        }

        case createAccountScene = "CreateAccount"
        static func instantiateCreateAccount() -> CreateAccViewController {
            guard let vc = StoryboardScene.Wizard.createAccountScene.viewController() as? CreateAccViewController
                else {
                    fatalError("ViewController 'CreateAccount' is not of the expected class CreateAccViewController.")
            }
            return vc
        }

        case preferencesScene = "Preferences"
        static func instantiatePreferences() -> UITableViewController {
            guard let vc = StoryboardScene.Wizard.preferencesScene.viewController() as? UITableViewController
                else {
                    fatalError("ViewController 'Preferences' is not of the expected class UITableViewController.")
            }
            return vc
        }

        case validatePasswordScene = "Validate_Password"
        static func instantiateValidatePassword() -> UIViewController {
            return StoryboardScene.Wizard.validatePasswordScene.viewController()
        }
    }
}

struct StoryboardSegue {
    enum Wizard: String, StoryboardSegueType {
        case showPassword = "ShowPassword"
    }
}

//: #### Usage Example

let createAccountVC = StoryboardScene.Wizard.createAccountScene.viewController()
createAccountVC.title

let validateVC = StoryboardScene.Wizard.validatePasswordScene.viewController()
validateVC.title

let segue = StoryboardSegue.Wizard.showPassword
createAccountVC.perform(segue: segue)

switch segue {
  case .showPassword:
    print("Working! 🎉")
  default:
    print("Not working! 😱")
}

/*******************************************************************************
This is a «real world» example of how you can benefit from the generated enum;
you can easily switch or directly compare the passed in `segue` with the corresponding
segues for a specific storyboard.
*******************************************************************************/
//override func prepareForSegue(_ segue: UIStoryboardSegue, sender sender: AnyObject?) {
//  switch UIStoryboard.Segue.Message(rawValue: segue.identifier)! {
//  case .Custom:
//    // Prepare for your custom segue transition
//  case .NonCustom:
//    // Pass in information to the destination View Controller
//  }
//}
