//
//  ViewController.swift
//  JokeApp
//
//  Created by Василий Ханин on 10.11.2024.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Private Properties
    private var alertPresenter: AlertPresenter?
    private var jokeService = JokeService()
    private var currentJoke: JokeModel?
    
    // MARK: - IB Outlets
    @IBOutlet weak var jokeIdLabel: UILabel!
    @IBOutlet weak var typeJokeLabel: UILabel!
    @IBOutlet weak var questioinLabel: UILabel!
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(viewСontroller: self)
        loadJoak()
        
        questioinLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    // MARK: - IB Actions
    @IBAction func showPunchlineButton(_ sender: Any) {
        let punchline = currentJoke?.punchline ?? "No punchline available"
        
        let alertModel = AlertModel(title: "Punchline",
                                    message: punchline,
                                    buttonText: "Ok",
                                    completion: nil)
        
        alertPresenter?.showAlert(model: alertModel)
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        loadJoak()
    }
    
    private func loadJoak() {
        jokeService.fetchJoke { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let joke):
                    self?.currentJoke = joke
                    self?.updateUI(with: joke)
                case .failure(let error):
                    print("Error fetching joke: \(error.localizedDescription)")
                    self?.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
        
    }
    private func updateUI(with joke: JokeModel) {
        jokeIdLabel.text = "\(joke.id)"
        typeJokeLabel.text = "\(joke.type)"
        questioinLabel.text = joke.setup
    }
    
    // MARK: - Error Handling
    private func showErrorAlert(message: String) {
        let alertModel = AlertModel(title: "Error", message: message, buttonText: "OK", completion: nil)
        alertPresenter?.showAlert(model: alertModel)
    }
}

