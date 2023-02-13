//
//  BookScreenViewController.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift

class BookScreenViewController: UIViewController, StoryboardLoadable {
    
    //MARK: -
    //MARK: Properties
    
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var author: UILabel?
    @IBOutlet weak var publishYear: UILabel?
    @IBOutlet weak var numberOfPages: UILabel?
    @IBOutlet weak var firstSentense: UILabel?
    @IBOutlet weak var returnButton: UIButton?    
    
    public var viewModel: BookScreenViewModel!
    private var disposeBag: DisposeBag = .init()
    
    //MARK: -
    //MARK: Init and Deinit
    
    public static func startVC(viewModel: BookScreenViewModel) -> BookScreenViewController {
        let contr = self.loadFromStoryboard(storyboardName: "BookScreen")
        contr.viewModel = viewModel
        return contr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        let searchScreenDestination = SearchScreenDestination()
        resolve(Router.self).route(to: searchScreenDestination)
    }
    
}
