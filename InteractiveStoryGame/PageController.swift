//
//  PageController.swift
//  InteractiveStoryGame
//
//  Created by Maheep Chhabra on 20/08/19.
//  Copyright © 2019 Splash Technologies. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page?
    
    // MARK: - User Interface Properties
    
    let artWork = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let page = page{
            artWork.image = page.story.artwork
            
            let attributedString  = NSMutableAttributedString(string: page.story.text)
            let paragraphStyle = NSMutableParagraphStyle()
            
            paragraphStyle.lineSpacing = 10
            paragraphStyle.alignment = .center
            
            
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            storyLabel.attributedText = attributedString
            
            if let firstChoice = page.firstChoice{
                firstChoiceButton.setTitle(firstChoice.title, for: .normal)
                firstChoiceButton.addTarget(self, action: #selector(PageController.loadFirstChoice), for: .touchUpInside )
            } else {
                firstChoiceButton.setTitle("Play Again", for: .normal)
                firstChoiceButton.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
            }
            
            
            if let secondChoice = page.secondChoice{
                secondChoiceButton.setTitle(secondChoice.title, for: .normal)
                secondChoiceButton.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
            }
            
        }
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artWork)
        view.addSubview(storyLabel)
        view.addSubview(firstChoiceButton)
        view.addSubview(secondChoiceButton)
        
        artWork.translatesAutoresizingMaskIntoConstraints = false
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        storyLabel.numberOfLines = 0
        
        
        NSLayoutConstraint.activate([
            artWork.topAnchor.constraint(equalTo: view.topAnchor),
            artWork.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artWork.leftAnchor.constraint(equalTo: view.leftAnchor),
            artWork.rightAnchor.constraint(equalTo: view.rightAnchor),
        
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0),
            
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40.0),
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
        
    }
    
    
    
    
    //MARK: - Helper Methods
    
    
    @objc func loadFirstChoice() {
        if let page = page, let firstChoice = page.firstChoice {
            let nextPage = firstChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    @objc func loadSecondChoice() {
        if let page = page, let secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    @objc func playAgain(){
        navigationController?.popToRootViewController(animated: true)
    }
    

}











