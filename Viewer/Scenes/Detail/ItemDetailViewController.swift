//
//  ItemDetailViewController.swift
//  Viewer
//
//  Created by Dario Suarez on 16/06/2019.
//  Copyright (c) 2019 Dario Suarez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ItemDetailDisplayLogic: class {
    func displayItem(viewModel: ItemDetail.Load.ViewModel)
}

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemTypeLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    var interactor: ItemDetailBusinessLogic?
    var router: (NSObjectProtocol & ItemDetailRoutingLogic & ItemDetailDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ItemDetailInteractor(worker: ItemDetailWorker(networking: Networking()))
        let presenter = ItemDetailPresenter()
        let router = ItemDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        activityIndicator.startAnimating()
        interactor?.doLoad()
    }
    
    func setupUI() {
        itemNameLabel.text = ""
        itemTypeLabel.text = ""
        itemPriceLabel.text = ""
        itemDescriptionLabel.text = ""
        descriptionLabel.isHidden = true
    }
}

extension ItemDetailViewController: ItemDetailDisplayLogic {
    func displayItem(viewModel: ItemDetail.Load.ViewModel) {
        activityIndicator.stopAnimating()
        itemNameLabel.text = viewModel.name
        itemTypeLabel.text = viewModel.type
        itemImageView.imageFromServerURL(urlString: viewModel.image)
        itemPriceLabel.text = viewModel.price
        itemDescriptionLabel.text = viewModel.desc
        descriptionLabel.isHidden = false
    }
}
