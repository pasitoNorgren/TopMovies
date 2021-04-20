//
//  CircleButton.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 19.04.2021.
//

import UIKit


class CircleButton: UIButton {
    
    internal lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        return shapeLayer
    }()
    
    private lazy var shapeLayerBlack: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.black.cgColor
        return shapeLayer
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        layer.addSublayer(shapeLayer)
        layer.addSublayer(shapeLayerBlack)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radiusVarColor = min(bounds.height, bounds.width) / 2
        let radiusBlackColor = radiusVarColor * 0.9
        shapeLayer.path = UIBezierPath(arcCenter: center, radius: radiusVarColor, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        shapeLayerBlack.path = UIBezierPath(arcCenter: center, radius: radiusBlackColor, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
    }
}
