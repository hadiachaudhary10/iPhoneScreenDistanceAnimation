//
//  ViewController.swift
//  SampleAnimationCloseScreen
//
//  Created by Dev on 12/02/2024.
//

import UIKit
import ViewAnimator

enum ArrowSize {
  case small
  case medium
  case large
}

class ViewController: UIViewController {
  
  var yPosition: CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "BackgroundColor")
    setUpUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(
      views: [continueButton, headingData, subHeadingData, arrowLarge],
      animations: [AnimationType.from(direction: .bottom, offset: 10)],
      delay: 0,
      duration: 0.75
    )
    
    animateLarge()
    animateMedium()
    animateSmall()
  }
  
  func animateMedium() {
    UIView.animate(
      views: [arrowMedium],
      animations: [AnimationType.from(direction: .bottom, offset: 20), AnimationType.identity],
      delay: 0,
      duration: 1.5,
      completion: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
          UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
              self.arrowMedium.alpha = 0
            },
            completion: { _ in
              self.animateMedium()
            }
          )
        }
      }
    )
  }
  
  func animateSmall() {
    UIView.animate(
      views: [arrowSmall],
      animations: [AnimationType.from(direction: .bottom, offset: 30), AnimationType.identity],
      delay: 0,
      duration: 1.5,
      completion: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
          UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
              self.arrowSmall.alpha = 0
            },
            completion: { _ in
              self.animateSmall()
            }
          )
        }
      }
    )
  }
  
  func animateLarge() {
    UIView.animate(
      views: [arrowLarge],
      animations: [AnimationType.from(direction: .bottom, offset: 10), AnimationType.identity],
      delay: 0,
      duration: 1.5,
      options: [.curveEaseInOut],
      completion: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
          UIView.animate(
            withDuration: 1.5,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
              self.arrowLarge.alpha = 0
            },
            completion: { _ in
              self.animateLarge()
            }
          )
        }
      })
  }
  
  lazy var continueButton: UIButton = {
    let width = 150.0
    let buttonView = UIButton(type: .system)
    buttonView.tintColor = .white
    buttonView.backgroundColor = .systemGray
    buttonView.setTitle("Continue", for: .normal)
    buttonView.frame = CGRect(x: UIScreen.main.bounds.width/2 - width/2, y: yPosition, width: width, height: 50)
    buttonView.layer.cornerRadius = 25
    
    buttonView.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    return buttonView
  }()
  
  @objc func buttonPressed(_ sender: UIButton) {}
  
  lazy var headingLabel: (String, CGFloat) -> UILabel = { [self] title, yLocation in
    let textfieldView = UILabel()
    textfieldView.frame.size.width =  UIScreen.main.bounds.width
    textfieldView.frame.origin.x = 0
    textfieldView.frame.origin.y = yLocation
    textfieldView.frame.size.height = CGFloat(50)
    textfieldView.text = title
    textfieldView.font = .boldSystemFont(ofSize: 35)
    textfieldView.textColor = .white
    textfieldView.textAlignment = .center
    
    return textfieldView
  }

  lazy var headingData: UIStackView = {
    let stackView = UIStackView()
    stackView.frame.size.width = UIScreen.main.bounds.width
    stackView.frame.size.height = CGFloat(100)
    stackView.frame.origin.x = 0
    stackView.frame.origin.y = yPosition
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = 10
    
    let yLocation = CGFloat(0)
    stackView.addSubview(headingLabel("iPhone May Be", yLocation))
    stackView.addSubview(headingLabel("Too Close", yLocation + 50))
    
    yPosition += 125
    
    return stackView
  }()
  
  lazy var subHeadingLabel: (String, CGFloat) -> UILabel = { [self] title, yLocation in
    let textfieldView = UILabel()
    textfieldView.frame.size.width =  UIScreen.main.bounds.width
    textfieldView.frame.origin.x = 0
    textfieldView.frame.origin.y = yLocation
    textfieldView.frame.size.height = CGFloat(30)
    textfieldView.text = title
    textfieldView.font.withSize(25)
    textfieldView.textColor = .white
    textfieldView.textAlignment = .center
    
    return textfieldView
  }
  
  lazy var subHeadingData: UIStackView = {
    let stackView = UIStackView()
    stackView.frame.size.width = UIScreen.main.bounds.width
    stackView.frame.size.height = CGFloat(60)
    stackView.frame.origin.x = 0
    stackView.frame.origin.y = yPosition
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = 10
    
    let yLocation = CGFloat(0)
    stackView.addSubview(subHeadingLabel("Keeping your iPhone at arm's length can", yLocation))
    stackView.addSubview(subHeadingLabel("protect your eyesight.", yLocation + 30))
    
    yPosition +=  240
    
    return stackView
  }()
  
  lazy var arrow: (ArrowSize) -> UIImageView = { [self] size in
    var width = 0.0
    var height = 0.0
    var arrowColorName = ""
    
    switch size {
      case .small:
        arrowColorName = "ArrowSmall"
        width = 80
        height = 20
      case .medium:
        arrowColorName = "ArrowMedium"
        width = 95
        height = 25
      case .large:
        arrowColorName = "ArrowLarge"
        width = 110
        height = 30
    }
    
    let imageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/2 - width/2, y: yPosition, width: width, height: height))
    
    if let image = UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold)) {
      imageView.image = image
    }
    
    imageView.tintColor = UIColor(named: arrowColorName)
    yPosition += 15
    
    return imageView
  }
  
  lazy var arrowSmall: UIImageView = {
    return arrow(.small)
  }()
  
  lazy var arrowMedium: UIImageView = {
    return arrow(.medium)
  }()
  
  lazy var arrowLarge: UIImageView = {
    return arrow(.large)
  }()
  
  lazy var arrowData: UIStackView = {
    let stackView = UIStackView()
    stackView.frame.size.width = UIScreen.main.bounds.width
    stackView.frame.size.height = CGFloat(120)
    stackView.frame.origin.x = 0
    stackView.frame.origin.y = yPosition
    stackView.alignment = .top
    stackView.distribution = .fill
    stackView.spacing = 10
    
    stackView.addSubview(arrowSmall)
    stackView.addSubview(arrowMedium)
    stackView.addSubview(arrowLarge)
    yPosition += 25
    
    return stackView
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.frame.size.width = UIScreen.main.bounds.width
    stackView.frame.size.height = UIScreen.main.bounds.height
    stackView.frame.origin.x = 0
    stackView.frame.origin.y = UIScreen.main.bounds.width - UIScreen.main.bounds.width/3
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 10
    
    stackView.addSubview(arrowData)
    stackView.addSubview(headingData)
    stackView.addSubview(subHeadingData)
    
    stackView.addSubview(continueButton)
    
    return stackView
  }()
  
  func setUpUI(){
    view.addSubview(stackView)
  }
}

