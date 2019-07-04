//
//  SearchPresenter.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright (c) 2019 Dario Suarez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchPresentationLogic {
    func presentSearchResult(response: SearchScene.Search.Response)
    func presentNoInternetConnection(response: NetworkingError.Response)
    func presentSearchError(response: NetworkingError.Response)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    func presentSearchResult(response: SearchScene.Search.Response) {
        var list = [SearchItemResultViewModel]()
        response.result?.results?.forEach { (item) in
            let vm = SearchItemResultViewModel(name: item.title ?? "",
                                               price: "$\(item.price ?? 0.0)",
                                               image: item.thumbnail ?? "")
            list.append(vm)
        }
        let resultVM = SearchScene.Search.ViewModel(result: list)
        viewController?.displaySearchResult(vm: resultVM)
    }
    
    func presentSearchError(response: NetworkingError.Response) {
        let vm = NetworkingError.ViewModel(title: "Viewer",
                                           detail: NSLocalizedString(response.message,
                                                                     comment: "Error servicio"))
        viewController?.displaySearchError(vm: vm)
        
    }
    
    func presentNoInternetConnection(response: NetworkingError.Response) {
        let vm = NetworkingError.ViewModel(title: "Viewer",
                                           detail: NSLocalizedString(response.message,
                                                                     comment: "No Internet"))
        viewController?.displayNoInternetConnection(vm: vm)
    }
}