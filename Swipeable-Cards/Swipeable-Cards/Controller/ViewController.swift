//
//  ViewController.swift
//  Swipeable-Cards
//
//  Created by kartic on 10/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import UIKit
import Model
import FLUtilities

class ViewController: UIViewController {

    @IBOutlet var icView: InvertedTimeMachine!
    @IBOutlet var progressView: UIProgressView!
    
    var cardModels = [CardViewModel]()
    var infoData: [Info] = [] {
        didSet {
            self.prepareModels()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        self.icView.configure()
        self.fetchData()
    }
    
    func setupCarousel() {
        self.icView.layer.masksToBounds = false
        self.icView.timeMachineDelegate = self
        self.icView.visibleCells = self.cardModels.count
    }
    
    @IBAction func resetButtonTapped() {
        self.icView.resetCards()
    }
    
    @IBAction func nextButtonTapped() {
        self.icView.nextCard()
    }
    
    @IBAction func previousButtonTapped() {
        self.icView.previousCard()
    }
    
    func prepareModels() {
        self.cardModels = self.infoData.map({ CardViewModel(text: $0.text) })
        self.setupCarousel()
        self.icView.reloadData()
        self.updateProgressView()
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
        print(progress)
        DispatchQueue.main.async {
            self.progressView.setProgress(progress, animated: true)
        }
    }
}

extension ViewController {
    func fetchData() {
        Info.fetchData { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.infoData = data
            case .failure(let error):
                // handle error here
                self?.showErrorAlert(message: error.message)
            }
        }
    }
}
