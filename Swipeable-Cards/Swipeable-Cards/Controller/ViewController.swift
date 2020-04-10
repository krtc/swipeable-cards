//
//  ViewController.swift
//  Swipeable-Cards
//
//  Created by kartic on 10/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var icView: InvertedTimeMachine!
    @IBOutlet var progressView: UIProgressView!
    
    var cardModels = [CardViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.cardModels = [CardViewModel(text: "asdfg"),
                           CardViewModel(text: "qwwerty"),
                           CardViewModel(text: "asdfg"),
                           CardViewModel(text: "qwwerty"),
                           CardViewModel(text: "asdfg"),
                           CardViewModel(text: "qwwerty")]
        
        self.icView.configure()
        self.setupCarousel()
        self.icView.reloadData()
        self.updateProgressView()
    }
    
    func setupCarousel() {
        self.icView.layer.masksToBounds = false
        self.icView.timeMachineDelegate = self
        self.icView.visibleCells = 3//self.cardModels.count
    }
    
    @IBAction func resetButtonTapped() {
        self.icView.resetCards()
    }
}

extension ViewController: InvertedTimeMachineProtocol {

    func numberOfItems(in carousel: iCarousel) -> Int {
        self.cardModels.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        if view == nil {
            if self.cardModels.count > 0 {
                let frame = CGRect(origin: icView.bounds.origin, size: CGSize(width: icView.frame.width - 40, height: (icView.frame.height) - 20))
                let cardView = CardView(frame: frame)
                cardView.model = self.cardModels[index]
                return cardView
            }
        }
        return view!
    }
    
    func updateProgressView() {
        let totalItemsIndexes = self.cardModels.count
        let progress: Float = (Float(self.icView.currentItemIndex + 1)/Float(totalItemsIndexes))
        DispatchQueue.main.async {
            self.progressView.setProgress(progress, animated: true)
        }
    }
}
