//
//  TutorialController.swift
//  Tole
//
//  Created by NURZHAN on 02.04.2018.
//  Copyright © 2018 Beknar Danabek. All rights reserved.
//

import UIKit
import Cartography

class TutorialCollectionViewController: UIViewController {
    
//    MARK: Properties
    
    private var currentPageIndex: IndexPath = IndexPath()
    
    private var dataArray: [Page] = [
        Page(image: #imageLiteral(resourceName: "Group 2"), imageOfInside: #imageLiteral(resourceName: "Bitmap Copy 10"), descriptionText: "Добавляете свой товар в прилодение и формируете склад", buttonTitle: "Далее"),
        Page(image: #imageLiteral(resourceName: "Group 2"), imageOfInside: #imageLiteral(resourceName: "phonee"), descriptionText: "Сканируете товар и считаете сумму к оплате", buttonTitle: "Далее"),
        Page(image: #imageLiteral(resourceName: "Group 2"), imageOfInside: #imageLiteral(resourceName: "LastImage"), descriptionText: "Выдаете чек и выявляете статистику продаж", buttonTitle: "Начать")
    ]
    
    lazy var swipeToNextPageGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(showNextPage))
        gesture.direction = .left
        return gesture
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TutorialCollectionViewCell.self, forCellWithReuseIdentifier: Constant.tutorialCellIdentifier)
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.addGestureRecognizer(swipeToNextPageGesture)
        
        return collectionView
    }()
    
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addConstraints()
        viewWillDisappear(true)
        
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
    }
    
//    MARK: Status bar mode
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    
//    MARK: Constraints
    private func addConstraints() {
        
        constrain(view, collectionView) { view, collectionView in
            collectionView.width == view.width
            collectionView.height == view.height
            collectionView.center == view.center
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}


//    MARK: UICollectionView Data Source
extension TutorialCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.tutorialCellIdentifier, for: indexPath) as! TutorialCollectionViewCell
        
        let page = dataArray[indexPath.row]
        
        cell.pageControl.currentPage = indexPath.item
        cell.tutorialImageView.image = page.image
        cell.tutorialImageInsideImage.image = page.imageOfInside
        
        //  Spacing between characters
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Constant.textLineSpacing
        
        let text = NSMutableAttributedString(string: page.descriptionText)
        text.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        cell.tutorialDescription.attributedText = text
        cell.tutorialDescription.textAlignment = .center
        cell.nextButton.setTitle(page.buttonTitle, for: .normal)
      
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.backgroundColor = .white
        if (cell as! TutorialCollectionViewCell).nextButton.titleLabel?.text == "Начать"{
            (cell as! TutorialCollectionViewCell).nextButton.addTarget(self, action: #selector(goBtnAction), for: .touchUpInside)
        }else{
            (cell as! TutorialCollectionViewCell).nextButton.addTarget(self, action: #selector(showNextPage), for: .touchUpInside)
        }
        
        
        
        currentPageIndex = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    MARK: Button Action
    @objc private func showNextPage() {
        
        let nextPage: IndexPath = IndexPath(item: currentPageIndex.item + 1, section: 0)
        
        collectionView.scrollToItem(at: nextPage, at: .centeredHorizontally, animated: true)
        
    }
    @objc private func goBtnAction() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Hello Bitches")
        
    }
    
}

//    MARK: Flow Layout Delegate
extension TutorialCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let height = view.bounds.height

        
        return CGSize(width: width, height: height)
        
    }
    
}

//    MARK: Model
struct Page {
    let image: UIImage
    let imageOfInside: UIImage
    let descriptionText: String
    let buttonTitle: String
}









