//
//  SelectionListVM.swift
//  ToursTest
//
//  Created by r.mustafin on 03.03.2024.
//

import Foundation
import UIKit

protocol SelectionListVMrotocol: UITableViewDataSource & UITableViewDelegate {
    var selectionType: SelectionListVM.SelectionType { get set }
    var reloadTableView: (() -> Void)? { get set }
    var dismiss: (() -> Void)? { get set }
    var placeholderText: String { get }
    func fetch()
    func filter(by string: String)
}


class SelectionListVM: NSObject, SelectionListVMrotocol {
    enum SelectionType {
        case cities
        case countries
    }
    
    var selectionType : SelectionType
    
    var placeholderText: String {
            switch selectionType {
            case .cities:
                return "Город вылетв"
            case .countries:
                return "Страна,курорт,отель"
            }
        }
    
    private var allModels = [SearchableModel]() {
        didSet {
            presentingModels = allModels
        }
    }

    private var presentingModels = [SearchableModel]() {
        didSet {
            reloadTableView?()
        }
    }
    weak var delegate: SelectionListDelegate?
    var reloadTableView: (() -> Void)?
    var dismiss: (() -> Void)?
    
    init(selectionType: SelectionType, delegate: SelectionListDelegate?) {
        self.selectionType = selectionType
        self.delegate = delegate
    }
    
    public func fetch() {
        switch selectionType {
        case .cities:
            fetchDepartCities()
        case .countries:
            fetchCountries()
        }
    }
    
    private func fetchDepartCities() {
          Networker.fetchDepartCities { [weak self] response in
              guard let response = response else { return }
              DispatchQueue.main.async {
                  self?.allModels = response
              }
          }
      }
    
    private func fetchCountries() {
          Networker.fetchCountries { [weak self] response in
              guard let response = response else { return }
              DispatchQueue.main.async {
                  self?.allModels = response
              }
          }
      }
    
    func filter(by string: String) {
        if string.count >= 1 {
            switch selectionType {
            case .cities:
                presentingModels = allModels.filter { $0.name.localizedCaseInsensitiveContains(string)
                }
            case .countries:
                presentingModels = allModels.filter { $0.name.localizedCaseInsensitiveContains(string)
                }
            }
        } else {
            presentingModels = allModels
        }
    }
    
}

extension SelectionListVM {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        presentingModels.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = presentingModels[indexPath.row].name
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = presentingModels[indexPath.row]
        switch selectionType{
        case .cities:
            delegate?.didSelectCity(name: selectedModel.name, id: selectedModel.id)
        case.countries:
            delegate?.didSelectCountry(name: selectedModel.name)
        }
        dismiss?()

    }
}
