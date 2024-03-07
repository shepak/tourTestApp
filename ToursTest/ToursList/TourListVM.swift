//
//  TourListVM.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//

import Foundation
import UIKit

protocol TourListVMProtocol: UITableViewDataSource {
    var reloadData: (() -> Void)? { get set }
    var isLoading: Bool { get set }
    var toggleLoadingView: ((_ status: Bool) -> Void)? { get set }
    func fetch(key: String, iteration: Int)
    var key: String { get }
    var fromDate: String { get }
    var duration: Int { get }
    var peopleCount: Int { get }
}

class TourListVM: NSObject, TourListVMProtocol {
   
    var naviagtionTitleText: String = ""
    
    var reloadData: (() -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            toggleLoadingView?(isLoading)
        }
    }

    var toggleLoadingView: ((Bool) -> Void)?

    var key: String
    var fromDate: String
    var duration: Int
    var peopleCount: Int
    
    var searchResults: SearchResults? {
            didSet {
                reloadData?()
            }
        }
    
    init(key: String,fromDate: String,duration: Int, peopleCount: Int ) {
        self.key = key
        self.fromDate = fromDate
        self.duration = duration
        self.peopleCount = peopleCount
    }
    
    
    public func fetch(key: String, iteration: Int) {
        isLoading = true
        Networker.getSearchResults(key: key) { [weak self] response in
            guard let response = response, iteration < 10 else { return }
            if response.stats.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self?.fetch(key: key,iteration: iteration + 1)
                }
            } else{
                DispatchQueue.main.async {
                    self?.searchResults = response
                }
            }
        }
    }
    
}

extension TourListVM {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return searchResults?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TourCell.identifier) as? TourCell {
            if let result = searchResults?.results[indexPath.row] {
                cell.setup(with: result.offer)
                cell.backgroundColor = .clear
            }
            
            return cell
        }
        return UITableViewCell()
    }
}

