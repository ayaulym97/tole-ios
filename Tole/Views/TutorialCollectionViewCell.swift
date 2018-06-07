//
//  TutorialCollectionCell.swift
//  Tole
//
//  Created by NURZHAN on 02.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class TutorialCollectionViewCell: UICollectionViewCell {
    
//    MARK: Properties
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .gray
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return pageControl
    }()
    
    lazy var tutorialImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var tutorialImageInsideImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var tutorialDescription: UILabel = {
        let textView = UILabel()
        textView.font = UIFont(name: "Helvetica", size: 20)
        textView.textColor = .gray
        textView.textAlignment = .center
        textView.numberOfLines = 2
        return textView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .aqua
        button.layer.cornerRadius = Constant.buttonCornerRadius
        return button
    }()
    
//    MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addCustomConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.addSubViews(views: [pageControl, tutorialImageView, tutorialDescription, nextButton])
        self.backgroundColor = #colorLiteral(red: 0.160166949, green: 0.3292732835, blue: 1, alpha: 1)
        
        tutorialImageView.addSubview(tutorialImageInsideImage)
        
    }
    
//    MARK: Constraints
    private func addCustomConstraints() {
        
        constrain(self, pageControl) { view, pageControl in
            
            pageControl.width == view.width
            pageControl.top == view.top + self.bounds.height / 20
            pageControl.centerX == view.centerX
            
        }
        
        constrain(pageControl, tutorialImageView) { pageControl, tutorialImageView in
            
            tutorialImageView.width == pageControl.width * 0.5 
            tutorialImageView.height == pageControl.width * 0.5
            tutorialImageView.top == pageControl.bottom + self.bounds.height / 13
            tutorialImageView.centerX == pageControl.centerX
            
        }
        
        constrain(self, nextButton, tutorialDescription) { view, nextButton, tutorialDescription in
            
            nextButton.width == view.width * 0.85
            nextButton.height == 50
            nextButton.centerX == view.centerX
            nextButton.bottom == view.bottom - self.bounds.height / 16
            
            tutorialDescription.width == nextButton.width
            tutorialDescription.height == nextButton.height * 1.4
            tutorialDescription.centerX == nextButton.centerX
            tutorialDescription.bottom == nextButton.top - self.bounds.height / 25
            
        }
        
        constrain(tutorialImageView, tutorialImageInsideImage) { bgImage, insideImage in
            insideImage.width == bgImage.width / 1.6
            insideImage.height == bgImage.height / 1.6
            insideImage.center == bgImage.center
        }
        
    }
    
}
