//
//  InvertedTimeMachineCarousel.swift
//  Swipeable-Cards
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation

protocol InvertedTimeMachineProtocol: class {
    func numberOfItems(in carousel: iCarousel) -> Int
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView
    func updateProgressView()
}

class InvertedTimeMachine: iCarousel, iCarouselDelegate, iCarouselDataSource {
  
    var carouselType: iCarouselType = iCarouselType.invertedTimeMachine
    
    weak var timeMachineDelegate: InvertedTimeMachineProtocol?
  
    var visibleCells: Int = 0
    
    func configure() {
        self.delegate = self
        self.dataSource = self
        self.isVertical = true
        self.scrollSpeed = 0.1
        self.type = self.carouselType
        
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.timeMachineDelegate?.numberOfItems(in: carousel) ?? 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        return self.timeMachineDelegate?.carousel(carousel, viewForItemAt: index, reusing: view) ?? UIView()
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        self.timeMachineDelegate?.updateProgressView()
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch (option)
        {
        case .wrap:
            return 0
        case .tilt:
            return 0.1
        case .spacing:
            return value * 0.2
        case .visibleItems:
            return CGFloat(self.visibleCells)
        default:
            return value
        }
    }
    
    func resetCards() {
        self.scrollToItem(at: 0, animated: true)
    }
    
    func nextCard() {
        let nextIndex = self.currentItemIndex + 1
        if nextIndex < self.visibleCells {
            self.scrollToItem(at: nextIndex, animated: true)
        }
    }
    
    func previousCard() {
        let previousIndex = self.currentItemIndex - 1
        if previousIndex >= 0 {
            self.scrollToItem(at: previousIndex, animated: true)
        }
    }
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return self.frame.width - 20
    }
}
