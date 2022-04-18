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
        json()
    }
    
    @IBAction func newQuotesButton() {
        json()
    }
    
    private func json() {
        guard let urlString = URL(string: Source.source.rawValue) else { return }
        URLSession.shared.dataTask(with: urlString) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            
            do {
                self.results = try JSONDecoder().decode([Quotes].self, from: data)
                DispatchQueue.main.async {
                    self.configure()
                }

            } catch let error {
                print(error.localizedDescription)
            }
                
        }.resume()
    }
    
    private func configure() {
        for value in results {
            quotesLabel.text = value.quote ?? "No"
            namePersone.text = value.character ?? "No"
            fetchImage(from: value.image ?? "Nil")
        }
    }
    
    private func fetchImage(from imageUrl: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: imageUrl) else { return }
            guard let image = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.personeImage.image = UIImage(data: image)
            }
        }
    }
    

}

