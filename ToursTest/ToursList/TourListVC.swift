//
//  TourListVC.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//

import Foundation
import UIKit

class TourListVC: UIViewController {
 
    var viewModel: TourListVMProtocol!

    private lazy var loadingIndicatior: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.startAnimating()
        loader.isHidden = true
        return loader
    }()
    
    private var infoLabel: CustomInfoLabel = {
        let label = CustomInfoLabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private var countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Турция"
        return label
    }()

    
    private let backButton = NavigationBackButton()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = viewModel
        tableView.delegate = self
        tableView.register(TourCell.self, forCellReuseIdentifier: TourCell.identifier)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = Specs.Color.lightGray
        tableView.backgroundView = loadingIndicatior
        return tableView
    }()

    init(viewModel: TourListVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bindToViewModel()
        setupTableView()
        view.backgroundColor = .white
        viewModel.fetch(key: viewModel.key, iteration: 0)
        setupStackView()
    }

    // MARK: - Private


    private func bindToViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.toggleLoadingView = { [weak self] isLoading in
            self?.loadingIndicatior.isHidden = !isLoading
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
        let backButtonImage = UIImage(named: "image")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton

        infoLabel.setupInfoNavigation(
            startDate: FormatDate.formateDate(fromDateFormat: "YYYY-MM-dd", date: viewModel.fromDate, toDateFormat: "dd MMM"),
            duration: viewModel.duration,
            people: viewModel.peopleCount
        )
    }
  
    
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [countryLabel, infoLabel])
        stackView.axis = .vertical
        stackView.spacing = 6
        navigationItem.titleView = stackView
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        print("Back button tapped")
    }
}

// MARK: - UITableViewDelegate

extension TourListVC: UITableViewDelegate {

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension

    }
}
