//
//  DetailsViewController.swift
//  Practica-Fundamentos-iOS
//
//  Created by David Robles Lopez on 27/12/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var heroeImageView: UIImageView!
    @IBOutlet weak var heroeNameLabel: UILabel!
    @IBOutlet weak var heroeDescLabel: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    
    var heroe: Heroe!
    var transformation: [Transformation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformationsButton.alpha = 0
        title = heroe.name
        
        heroeImageView.setImage(url: heroe.photo)
        heroeNameLabel.text = heroe.name
        heroeDescLabel.text = heroe.description
        
        let token = LocalDataLayer.shared.getToken()
        
        NetworkLayer
            .shared
            .fetchTransformations(token: token, heroeId: heroe.id) { [weak self] allTrans, error in
                guard let self = self else { return }
                
                if let allTrans = allTrans {
                    self.transformation = allTrans
                    
                    if !self.transformation.isEmpty {
                        DispatchQueue.main.async {
                            self.transformationsButton.alpha = 1
                        }
                    }
                    
                } else {
                    print("error fetching transformation", error?.localizedDescription ?? "")
                }
            }
    }
    
    
    
    @IBAction func transformationButtonTapped(_ sender: UIButton) {
        
        let transView = TransformationViewController()
        transView.transformations = self.transformation.sorted(by: { transformation1, transformation2 in     // me devuelve lista ordenada
            let transformation1Index = Int(transformation1.name.split(separator: ".").first ?? "") ?? .zero
            let transformation2Index = Int(transformation2.name.split(separator: ".").first ?? "") ?? .zero
            return transformation1Index < transformation2Index
        })
        
        navigationController?.pushViewController(transView, animated: true)
     }
    
    

}
