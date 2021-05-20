//
//  FeedBackViewController.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit
import Cosmos

final class FeedBackViewController: UIViewController {
    
    private let feedbackTextView = UITextView()
    private let ratingView = CosmosView()
    private let sendFeedbackButton = CustomButton(title: "Отправить отзыв",
                                                  bgColor: .systemBlue,
                                                  cornerRadius: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(feedbackTextView, ratingView, sendFeedbackButton)
        
        feedbackTextView.text            = "Ваш отзыв"
        feedbackTextView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        feedbackTextView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints       = false
        
        sendFeedbackButton.addTarget(self, action: #selector(fedButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            feedbackTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedbackTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedbackTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedbackTextView.heightAnchor.constraint(equalToConstant: 300),
            
            ratingView.topAnchor.constraint(equalTo: feedbackTextView.bottomAnchor, constant: 20),
            ratingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sendFeedbackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            sendFeedbackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            sendFeedbackButton.heightAnchor.constraint(equalToConstant: 44),
            sendFeedbackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    @objc private func fedButtonTapped() {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Отзыв отправлен",
                                      message: "Спасибо за ваш отзыв",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
