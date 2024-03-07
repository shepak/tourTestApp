//
//  SearchToursView.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation
import UIKit
import SnapKit

class SearchToursView: UIViewController, SelectionListDelegate {
    
    // MARK: - Properties
    private let fromTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Откуда"
        textField.textPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textField
    }()
    
    private let toTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Куда"
        textField.textPadding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textField
    }()
    
    private let departureDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата вылета"
        label.textColor = .lightGray
        return label
    }()
    
    private let departureDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = Specs.Color.lightGray
        return datePicker
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество"
        label.textColor = .lightGray
        return label
    }()
    
    private let durationTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.textPadding = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        return textField
    }()
    
    private let numberOfTravelersLabel: UILabel = {
        let label = UILabel()
        label.text = "Кто едет"
        label.textColor = .lightGray
        return label
    }()
    
    private let numberOfTravelersTF: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.textPadding = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        return textField
    }()
    
    private let departuresStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = Specs.Color.lightGray
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = Specs.Color.lightGray
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()
    private let departureDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .clear
        stackView.spacing = 2
        return stackView
    }()
    private let durationStackVIew: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 1
        return stackView
    }()
    
    private let numberOfTravelersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 2
        return stackView
    }()
    
    
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Найти тур", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 16
        return button
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Поиск туров"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        setupTextField()
        
        fromTextField.addTarget(self, action: #selector(fromTextFieldTapped), for: .touchDown)
        toTextField.addTarget(self, action: #selector(toTextFieldTapped), for: .touchDown)
        searchButton.addTarget(self, action: #selector(searchTourDidTapped), for: .touchUpInside)
    }
    var departCityId: Int?
    
    func didSelectCity(name: String, id: Int) {
        fromTextField.text = name
        departCityId = id
    }
    func didSelectCountry(name: String) {
        toTextField.text = name
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        
        view.backgroundColor = .white
        
    
        view.addSubview(departuresStackView)
        view.addSubview(infoStackView)
        view.addSubview(searchButton)
        departuresStackView.addArrangedSubview(fromTextField)
        departuresStackView.addSeparator(of: 2)
        departuresStackView.addArrangedSubview(toTextField)
        
        departureDateStackView.addArrangedSubview(departureDateLabel)
        departureDateStackView.addArrangedSubview(departureDatePicker)
        
        durationStackVIew.addArrangedSubview(durationLabel)
        durationStackVIew.addArrangedSubview(durationTextField)
        
        horizontalStackView.addArrangedSubview(departureDateStackView)
        horizontalStackView.addSeparator(of: 2)
        horizontalStackView.addArrangedSubview(durationStackVIew)
        
        numberOfTravelersStackView.addArrangedSubview(numberOfTravelersLabel)
        numberOfTravelersStackView.addArrangedSubview(numberOfTravelersTF)
        
        infoStackView.addArrangedSubview(horizontalStackView)
        infoStackView.addSeparator(of: 2)
        infoStackView.addArrangedSubview(numberOfTravelersStackView)

        
        
        departuresStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(113)
        }
        
        fromTextField.snp.makeConstraints { make in
            make.height.equalTo(departuresStackView).multipliedBy(0.49)
        }
        toTextField.snp.makeConstraints { make in
            make.height.equalTo(departuresStackView).multipliedBy(0.49)
        }
        departureDateStackView.snp.makeConstraints{ make in
            make.width.equalTo(horizontalStackView).multipliedBy(0.49)
        }
        durationStackVIew.snp.makeConstraints{ make in
            make.width.equalTo(horizontalStackView).multipliedBy(0.49)
        }
        
        departureDateLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(16)
        }
        departureDatePicker.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(16)
        }
        
    
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(departuresStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(113)
        }
        
        horizontalStackView.snp.makeConstraints{ make in
            make.height.equalTo(infoStackView).multipliedBy(0.49)
        }
        numberOfTravelersStackView.snp.makeConstraints{ make in
            make.height.equalTo(infoStackView).multipliedBy(0.49)
        }
        
        numberOfTravelersLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(16)
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
       
    }

    private func setupTextField(){
        durationTextField.keyboardType = .numberPad
        durationTextField.addTarget(self, action: #selector(durationTextFieldDidChange), for: .editingChanged)
        numberOfTravelersTF.keyboardType = .numberPad
        numberOfTravelersTF.addTarget(self, action: #selector(numberOfTravelersTFTextFieldDidChange), for: .editingChanged)
    }
    
    @objc private func fromTextFieldTapped() {
        let selectionListVC = SelectionListVC(viewModel: SelectionListVM(selectionType: .cities,delegate: self))
        let navController = UINavigationController(rootViewController: selectionListVC)
        navController.modalPresentationStyle = .pageSheet
        navController.modalTransitionStyle = .coverVertical
        navController.view.backgroundColor = .clear
        present(navController, animated: true, completion: nil)
        
    }
    
    @objc private func toTextFieldTapped() {
        let selectionListVC = SelectionListVC(viewModel: SelectionListVM(selectionType: .countries, delegate: self))
        let navController = UINavigationController(rootViewController: selectionListVC)
        navController.modalPresentationStyle = .pageSheet
        navController.modalTransitionStyle = .coverVertical
        navController.view.backgroundColor = .clear
        present(navController, animated: true, completion: nil)
        
    }
    @objc private func searchTourDidTapped() {
        
        let selectedDate = departureDatePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        guard let departCityId = departCityId else { return }
       
        
        guard let durationValue = extractIntFromTextField(textField: durationTextField) else { return }
        guard let numberOfTravalersValue = extractIntFromTextField(textField: numberOfTravelersTF) else { return }
        
        let parameters = SearchParameters(
            departCityID: departCityId,
            regionIds: [1601],
            startFrom: formattedDate,
            startTo: "20-09-2024",
            durationFrom: durationValue,
            durationTo: durationValue,
            adults: numberOfTravalersValue
        )
        
        Networker.searchTours(parameters: .init(search: parameters)) { [weak self] response in
            guard let response = response else { return }
            DispatchQueue.main.async {
                let tourVC = TourListVC(viewModel: TourListVM(
                    key: response.key,
                    fromDate:response.startFrom,
                    duration: response.durationTo,
                    peopleCount: response.durationTo
                )
                )
                    self?.navigationController?.pushViewController(tourVC, animated: true)
                }
        }
    }
    
    @objc private func durationTextFieldDidChange() {
        guard let text = durationTextField.text, !text.isEmpty else { return }
        
        if let number = Int(text) {
            
            switch number {
            case 1:
                durationTextField.text = "\(number) ночь"
            case 2...4:
                durationTextField.text = "\(number) ночи"
            default:
                durationTextField.text = "\(number) ночей"
            }
        }
    }
    
    @objc private func numberOfTravelersTFTextFieldDidChange() {
        guard let text = numberOfTravelersTF.text, !text.isEmpty else { return }
        
        if let number = Int(text) {
            
            switch number {
            case 1:
                numberOfTravelersTF.text = "\(number) взрослый"
            default:
                numberOfTravelersTF.text = "\(number) взрослых"
            }
        }
    }
    
    func extractIntFromTextField(textField: UITextField) -> Int? {
    
        let components = textField.text?.components(separatedBy: " ")

        if let firstComponent = components?.first {
            if let value = Int(firstComponent) {
                return value
            }
        }
        return nil
    }
    
    func requestSearchTours() {
        
    }

}
