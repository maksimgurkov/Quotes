//
//  ViewController.swift
//  Quotes
//
//  Created by Максим Гурков on 18.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personeImage: UIImageView!
    
    @IBOutlet weak var quotesLabel: UILabel!
    @IBOutlet weak var namePersone: UILabel!
    
    private var results: [Quotes] = []
    
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiIndicator.startAnimating()
        networkManager()
    }
    
    @IBAction func newQuotesButton() {
        networkManager()
    }
    
    private func networkManager() {
        activitiIndicator.startAnimating()
        NetworkManager.shared.fetchDataWithAlamofire(for: Link.source.rawValue) { result in
            switch result {
            case .success(let quotes):
                self.results = quotes
                self.configure()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configure() {
        for value in results {
            quotesLabel.text = value.quote ?? "No"
            namePersone.text = value.character ?? "No"
            fetchImage(from: value.image ?? "Nil")
            activitiIndicator.stopAnimating()
        }
    }
    
    private func fetchImage(from imageString: String) {
        ImageManager.shered.fetchImage(from: imageString) { imageData in
            self.personeImage.image = UIImage(data: imageData)
            
        }
    }
}

