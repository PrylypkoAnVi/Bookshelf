//
//  AppRouter.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit

protocol Destination {
    var destination: UIViewController? { get }
}

protocol Router {
    var currentViewController: UIViewController? { get }
    
    @discardableResult
    func route(to: Destination) -> UIViewController?
    
    func showError(err: String, show: Bool)
    
    func loading(show: Bool)
}

class AppRouter: Router {

    public var currentViewController: UIViewController? {
        return navigationController.topViewController
    }
    
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
        window.makeKeyAndVisible()
    }
    
    @discardableResult
    public func route(to destination: Destination) -> UIViewController? {
        guard let newViewController = destination.destination else { return nil }
        show(viewController: newViewController)
        return newViewController
    }
    
    public func showError(err: String, show: Bool) {
        let alert = UIAlertController(title: "Error", message: err, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.loading(show: false)
        self.currentViewController?.present(alert, animated: false, completion: nil)
    }
    
    public func loading(show: Bool) {
        let loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingAlert.view.addSubview(loadingIndicator)
        switch show {
        case true:
            loadingIndicator.startAnimating()
            self.currentViewController?.present(loadingAlert, animated: false, completion: nil)
            self.currentViewController?.view.isUserInteractionEnabled = false
        case false:
            loadingIndicator.stopAnimating()
            self.currentViewController?.dismiss(animated: false, completion: nil)
            self.currentViewController?.view.isUserInteractionEnabled = true
        }
    }
    
    private func show(viewController contr: UIViewController, animated: Bool = true) {
        guard currentViewController != contr else { return }
        self.navigationController.pushViewController(contr, animated: animated)
        self.navigationController.setViewControllers([contr], animated: animated)
    }
}

