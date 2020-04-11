//
//  CardView.swift
//  Swipeable-Cards
//
//  Created by kartic on 10/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation

struct CardViewModel {
    var text: String
}

class CardView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var descLabel: UILabel!
    
    var model: CardViewModel? {
        didSet {
            self.descLabel.text = self.model?.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(CardView.className, owner: self, options: nil)
        self.contentView.fixInView(self)
    }

}
