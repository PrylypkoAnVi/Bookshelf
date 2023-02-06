//
//  StoryboardLoadable.swift
//  Bookshelf
//
//  Created by Anastasia on 06.02.2023.
//

import UIKit

protocol StoryboardLoadable {
    static func loadFromStoryboard(storyboardName: String?) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard(storyboardName: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyboardName ?? String(describing: Self.self), bundle: Bundle(for: Self.self))
        print("Loading: \(String(describing: Self.self))")
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self ?? Self()

        return controller
    }
}
