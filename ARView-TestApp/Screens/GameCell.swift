//
//  GameCell.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit
import Kingfisher

class GameCell: UITableViewCell {
    
    static let reuseID  = "GameCell"
    private let gameCover: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let viewersIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "eye")
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let channelsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .systemRed
        imageView.image = UIImage(systemName: "play.rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gameNameLabel = CustomLabel(fontSize: 26, fontWeight: .bold)
    private let viewersLabel  = CustomLabel(fontSize: 16, fontWeight: .medium)
    private let channelsLabel = CustomLabel(fontSize: 16, fontWeight: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(stream: Top) {
        gameNameLabel.text = stream.game.name
        let url = URL(string: stream.game.logo.large)
        gameCover.kf.setImage(with: url)
        viewersLabel.text = String(stream.viewers)
        channelsLabel.text = String(stream.channels)
    }
    
    private func configure() {
        let viewersStack  = UIStackView(arrangedSubviews: [viewersIcon, viewersLabel])
        let channelsStack = UIStackView(arrangedSubviews: [channelsLabel, channelsIcon])
        viewersStack.spacing  = 6
        channelsStack.spacing = 6
        
        let stackView = UIStackView(arrangedSubviews: [viewersStack, channelsStack])
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(gameCover, gameNameLabel, stackView)
        gameNameLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            gameCover.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameCover.heightAnchor.constraint(equalToConstant: 160),
            gameCover.widthAnchor.constraint(equalToConstant: 120),
            
            gameNameLabel.leadingAnchor.constraint(equalTo: gameCover.trailingAnchor, constant: 8),
            gameNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            stackView.leadingAnchor.constraint(equalTo: gameCover.trailingAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
