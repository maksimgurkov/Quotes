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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager()
    }
    
    @IBAction func newQuotesButton() {
        networkManager()
    }
    
    private func networkManager() {
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
        }
    }
    
    private func fetchImage(from imageString: String) {
        guard let imageResult = ImageManager.shered.fetchImage(from: imageString) else { return }
        DispatchQueue.main.async {
            self.personeImage.image = UIImage(data: imageResult)
        }
    }
}

