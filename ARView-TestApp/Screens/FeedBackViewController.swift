//
//  FeedBackViewController.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

final class FeedBackViewController: UIViewController {
    
    private let feedbackTextView = UITextView()
    private let sendFeedbackButton = CustomButton(title: "Отправить отзыв", bgColor: .systemBlue, cornerRadius: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureUI() {
        view.addSubviews(feedbackTextView, sendFeedbackButton)
        feedbackTextView.text = "Ваш отзыв о программе"
        feedbackTextView.backgroundColor = .secondaryLabel
        feedbackTextView.translatesAutoresizingMaskIntoConstraints = false
        sendFeedbackButton.addTarget(self, action: #selector(fedButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            feedbackTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            feedbackTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            feedbackTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            feedbackTextView.heightAnchor.constraint(equalToConstant: 200),
            
            sendFeedbackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            sendFeedbackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            sendFeedbackButton.heightAnchor.constraint(equalToConstant: 44),
            sendFeedbackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    @objc private func fedButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
