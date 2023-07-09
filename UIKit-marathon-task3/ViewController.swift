//
//  ViewController.swift
//  UIKit-marathon-task3
//
//  Created by Руслан Сабиров on 08/07/2023.
//

import UIKit


class ViewController: UIViewController {
    private lazy var rectView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(rectView)
        view.addSubview(slider)
        rectView.backgroundColor = .red
        rectView.layer.cornerRadius = 6
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            rectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: rectView.layoutMargins.left),
            rectView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rectView.widthAnchor.constraint(equalToConstant: 100),
            rectView.heightAnchor.constraint(equalToConstant: 100),
            
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: slider.layoutMargins.left),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -slider.layoutMargins.right),
            slider.topAnchor.constraint(equalTo: rectView.bottomAnchor, constant: 50)
        ])
    }
    
    private func animateView() {
        let value = CGFloat(slider.value)
        let scale = (1 + (value / 2))
        let newRectSize = 100 * scale

        let endPoint = slider.frame.width + view.layoutMargins.left - (newRectSize / 2 + view.layoutMargins.right)
        let startPoint = (slider.frame.origin.x + newRectSize / 2)

        let newXCoordinate = endPoint * value + startPoint * (1 - value)
        
        let rotationTransform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2 * value)
        let scaledTransform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        UIView.animate(withDuration: 0.3) {
            self.rectView.center.x = newXCoordinate
            self.rectView.transform = CGAffineTransformConcat(rotationTransform, scaledTransform)
        }
    }

    
    @objc private func sliderChanged(_ slider: UISlider) {
        if slider.isTracking {
            animateView()
        } else {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.slider.setValue(1, animated: true)
                self?.animateView()
            }
        }
    }
}
