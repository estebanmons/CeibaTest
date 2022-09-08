//
//  BaseWireframe.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 6/09/22.
//

import UIKit

protocol WireframeInterface: AnyObject {
    func showAlert(_ title: String, message: String)
    func showAlertWithAction(_ title: String, message: String, handler: @escaping () -> Void)
    func initActivityIndicator(animated: Bool)
    func endActivityIndicator(animated: Bool)
}

extension WireframeInterface {
    
    func showAlert(_ title: String, message: String) {
        showAlert(title, message: message)
    }
    
    func showAlertWithAction(_ title: String, message: String, handler: @escaping () -> Void) {
        showAlertWithAction(title, message: message, handler: handler)
    }
    
    func initActivityIndicator(animated: Bool) {
        initActivityIndicator(animated: animated)
    }
    
    func endActivityIndicator(animated: Bool) {
        endActivityIndicator(animated: animated)
    }
}

class BaseWireframe {

    private unowned var _viewController: UIViewController

    // We need it in order to retain the view controller reference upon first access
    private var temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }
    
    var topViewController: UIViewController {
        return viewController.getTopViewController()
    }
}

extension BaseWireframe: WireframeInterface {
    
    func showAlert(_ title: String, message: String) {
        self.viewController.showAlertWithTitle(title, message: message)
    }
    
    func showAlertWithAction(
        _ title: String,
        message: String,
        handler: @escaping () -> Void
    ) {
        self.viewController.showAlertWithActions(title, message: message, handler: handler)
    }
}

extension BaseWireframe {

    var viewController: UIViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    func initActivityIndicator(animated: Bool) {
        let activityIndicator = ActivityIndicator()
        activityIndicator.startAnimating()
        activityIndicator.modalPresentationStyle = .overFullScreen
        activityIndicator.modalTransitionStyle = .crossDissolve
        topViewController.present(activityIndicator, animated: animated)
    }
    
    func endActivityIndicator(animated: Bool) {
        topViewController.dismiss(animated: animated)
    }
}

extension UIViewController {

    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
    func showAlertWithTitle(_ title: String, message: String, buttonTitle: String = Constants.Alert.accept) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: buttonTitle, style: .cancel, handler: nil))
        DispatchQueue.main.async(execute: {
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func showAlertWithActions(
        _ title: String,
        message: String,
        handler: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.Alert.accept, style: .cancel, handler: { _ in
            handler()
        })
        alertController.addAction(action)
        DispatchQueue.main.async(execute: {
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func getTopViewController() -> UIViewController {
        if let tabBarController = self as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return (selectedViewController as? UINavigationController)?.visibleViewController ?? selectedViewController
        } else if let navigationController = self as? UINavigationController,
                  let visibleViewController = navigationController.visibleViewController {
            return visibleViewController
        } else if let child = children.last {
            return (child as? UINavigationController)?.visibleViewController ?? child
        } else {
            return self
        }
    }
}

extension UINavigationController {

    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

