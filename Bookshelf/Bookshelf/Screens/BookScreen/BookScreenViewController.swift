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
        if let cover = cover {
//            guard let img = UIImage(named: "loading") else { return }
            
            self.viewModel.coverImage.asObservable().bind(to: cover.rx.image).disposed(by: disposeBag)
            
//            self.viewModel.cover.asObservable().map{$0.image).bind(onNext: { image in
//                if let image = image {
//                    cover.image = image
//                }
//            }).disposed(by: disposeBag)
            
            
//            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
//                if let image = self.viewModel.cover.value.image {
//                    UIView.transition(with: cover,
//                                      duration: 0.5,
//                                      options: .transitionCrossDissolve,
//                                      animations: { cover.image = image },
//                                      completion: nil)
//
//                    timer.invalidate()
//                }
//            }
        }
                              
        self.name?.text = self.viewModel.book.title
        self.author?.text = self.viewModel.book.author
        self.publishYear?.text = "Publish year: \(self.viewModel.book.publishYear)"
        self.numberOfPages?.text = "Number of pages: \(self.viewModel.book.numberOfPages)"
        self.firstSentense?.text = self.viewModel.book.firstSentense
    }

    //MARK: -
    //MARK: @IBAction
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        let searchScreenDestination = SearchScreenDestination()
        resolve(Router.self).route(to: searchScreenDestination)
    }
    
}
