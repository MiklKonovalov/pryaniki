//
//  ViewController.swift
//  Pryaniky_test
//
//  Created by Misha on 26.05.2022.
//

import UIKit
import Dropper
import Kingfisher

final class ViewController: UIViewController, DropperDelegate {
    
    private var viewModel: ViewModel
    
    private let dropper = Dropper(width: 75, height: 200)
    
    private var nameButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor.orange.cgColor
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(nameButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
    
    private var selectorButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor.orange.cgColor
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(selectorButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    
    private var bottomNameButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor.red.cgColor
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(bottomNameButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()


    //MARK: -Init
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        view.addSubview(nameButton)
        view.addSubview(selectorButton)
        view.addSubview(dropper)
        view.addSubview(imageView)
        view.addSubview(bottomNameButton)
        
        dropper.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        
        viewModel.getDataFromViewModel()
        
        viewModel.viewModelDidChange = {
            DispatchQueue.main.async {
                self.nameButton.setTitle(self.viewModel.nameLabel, for: .normal)
                self.selectorButton.setTitle(self.viewModel.dataService.datum[2].name, for: .normal)
                self.imageView.kf.setImage(with: self.viewModel.imageURL)
                self.bottomNameButton.setTitle(self.viewModel.nameLabel, for: .normal)
            }
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
    }

    //-MARK: Functions
    
    func setupConstraints() {
        
        nameButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        nameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        selectorButton.topAnchor.constraint(equalTo: nameButton.bottomAnchor, constant: 50).isActive = true
        selectorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectorButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        imageView.topAnchor.constraint(equalTo: selectorButton.bottomAnchor, constant: 50).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        bottomNameButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        bottomNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomNameButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomNameButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        selectorButton.setTitle(contents, for: .normal)
        print("id: \(contents), text: \(String(describing: viewModel.dataService.datum[2].data.variants?[path.item].text))")
    }
    
    //MARK: -Selectors
    
    @objc func nameButtonPressed() {
        print("text: \(String(describing: viewModel.dataService.datum.first?.data.text ?? "No text"))")
    }
    
    @objc func selectorButtonPressed() {
        let stringArray = viewModel.selectorArray.map { String($0) }
        if dropper.status == .hidden {
            dropper.items = stringArray
            dropper.theme = Dropper.Themes.white
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.center, button: nameButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("text: \(String(describing: viewModel.dataService.datum[1].data.text ?? "No text"))")
    }
    
    @objc func bottomNameButtonPressed() {
        print("text: \(String(describing: viewModel.dataService.datum.first?.data.text ?? "No text"))")
    }

}

