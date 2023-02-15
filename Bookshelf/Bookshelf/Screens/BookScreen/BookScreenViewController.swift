//
//  BookScreenViewController.swift
//  Bookshelf
//
//  Created by Anastasia on 12.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

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
        self.viewModel.cover.asObservable().map{$0}.bind(to: (self.cover?.rx.image)!).disposed(by: disposeBag)
        self.viewModel.title.asObservable().map{$0}.bind(to: (self.name?.rx.text)!).disposed(by: disposeBag)
        self.viewModel.author.asObservable().map{$0}.bind(to: (self.author?.rx.text)!).disposed(by: disposeBag)
        self.viewModel.publishYear.asObservable().map{$0}.bind(to: (self.publishYear?.rx.text)!).disposed(by: disposeBag)
        self.viewModel.firstSentense.asObservable().map{$0}.bind(to: (self.name?.rx.text)!).disposed(by: disposeBag)
        self.viewModel.pages.asObservable().map{$0}.bind(to: (self.numberOfPages?.rx.text)!).disposed(by: disposeBag)
    }
    
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        let searchScreenDestination = SearchScreenDestination()
        resolve(Router.self).route(to: searchScreenDestination)
    }
    
}
