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
        self.currentViewController?.present(alert, animated: true, completion: nil)
    }
    
    public func loading(show: Bool) {
        let loadingIndicator = UIActivityIndicatorView()
        guard let width = self.currentViewController?.view.frame.width,
              let height = self.currentViewController?.view.frame.height
        else {
            return
        }
        loadingIndicator.frame.size = CGSize(width: width, height: height)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
//        self.currentViewController?.view.addSubview(loadingIndicator)
        switch show {
        case true:
            self.currentViewController?.view.addSubview(loadingIndicator)
            loadingIndicator.startAnimating()
            self.currentViewController?.view.isUserInteractionEnabled = false
        case false:
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
            self.currentViewController?.view.isUserInteractionEnabled = true
        }
    }
    
    private func show(viewController contr: UIViewController, animated: Bool = true) {
        guard currentViewController != contr else { return }
        self.navigationController.pushViewController(contr, animated: animated)
        self.navigationController.setViewControllers([contr], animated: animated)
    }
}

