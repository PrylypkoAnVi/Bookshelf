//
//  BookScreenViewController.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift

class BookScreenViewController: UIViewController, StoryboardLoadable, UITextViewDelegate {
    
    //MARK: -
    //MARK: Properties
    
    @IBOutlet weak private var cover: UIImageView?
    @IBOutlet weak private var name: UILabel?
    @IBOutlet weak private var author: UILabel?
    @IBOutlet weak private var publishYear: UILabel?
    @IBOutlet weak private var numberOfPages: UILabel?
    @IBOutlet weak private var firstSentense: UITextView?
    @IBOutlet weak private var returnButton: UIButton?
    
    private var viewModel: BookScreenViewModel!
    private var disposeBag: DisposeBag = .init()
    
    //MARK: -
    //MARK: Init and Deinit
    
    public static func startVC(viewModel: BookScreenViewModel) -> BookScreenViewController {
        let contr = self.loadFromStoryboard(storyboardName: "BookScreen")
        contr.viewModel = viewModel
        return contr
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        self.firstSentense?.delegate = self
        setBookData()
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    //MARK: -
    //MARK: Private Methods
    
    private func setBookData() {
        if let cover = cover {
            self.viewModel.coverImage.asObservable().bind(to: cover.rx.image).disposed(by: disposeBag)
        }
        self.name?.text = self.viewModel.book.title
        self.author?.text = self.viewModel.book.author
        self.publishYear?.text = "Publish year: \(self.viewModel.book.publishYear)"
        self.numberOfPages?.text = "Number of pages: \(self.viewModel.book.numberOfPages)"
        self.firstSentense?.text = self.viewModel.book.firstSentense
    }

    //MARK: -
    //MARK: @IBAction
    
    @IBAction private func returnButtonPressed(_ sender: Any) {
        let searchScreenDestination = SearchScreenDestination()
        resolve(Router.self).route(to: searchScreenDestination)
    }
    
}
