//
//  SelectionListVC.swift
//  ToursTest
//
//  Created by r.mustafin on 02.03.2024.
//

import UIKit

class SelectionListVC: UIViewController {
    
    var viewModel: SelectionListVMrotocol
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var searchTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = viewModel.placeholderText
        textField.textPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textField.backgroundColor = Specs.Color.lightGray
        textField.layer.cornerRadius = 16
        return textField
    }()
    
    private let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Поиск по городам"
            return searchBar
        }()
    
    private let dView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
        }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private var departCities: [DepartCity] = []
    private var countries: [Country] = []
    

    var currentSearchText = ""

    // MARK: - Lifecycle

    init(viewModel: SelectionListVMrotocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindToViewModel()
        viewModel.fetch()
        searchTextField.delegate = self
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    
    @objc private func close() {
        dismiss(animated: true)
    }

    private func bindToViewModel() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.dismiss = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func setupUI(){
        view.addSubview(dView)
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        view.addSubview(closeButton)
        
        dView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(4)
            make.width.equalTo(36)
            make.centerX.equalToSuperview()
        }
        
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(dView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.left.equalTo(searchTextField.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    

    
}

extension SelectionListVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text{
            viewModel.filter(by: text)
        }
        return true
    }
    
}
