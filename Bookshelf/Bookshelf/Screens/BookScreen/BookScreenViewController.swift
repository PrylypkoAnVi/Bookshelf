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
        setBookData()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    //MARK: -
    //MARK: Private Methods
    
    private func setBookData() {
        guard let img = UIImage(named: "loading") else { return }
        if let cover = cover {
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if self.viewModel.cover.value.image == nil {
                    cover.image = img
                } else {
                    UIView.transition(with: cover,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { cover.image = self.viewModel.cover.value.image },
                                      completion: nil)
                    
                    timer.invalidate()
                }
            }
        }
        self.name?.text = self.viewModel.book.title
        self.author?.text = self.viewModel.book.author
        self.publishYear?.text = "Publish year: \(self.viewModel.book.publishYear)"
        self.numberOfPages?.text = "Number of pages: \(self.viewModel.book.numberOfPages)"
        self.firstSentense?.text = self.viewModel.book.firstSentense
        self.firstSentense?.contentMode = .top
    }

    //MARK: -
    //MARK: @IBAction
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        let searchScreenDestination = SearchScreenDestination()
        resolve(Router.self).route(to: searchScreenDestination)
    }
    
}
