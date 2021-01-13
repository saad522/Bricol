//
//  MessageSMSViewController.swift
//  Bricol
//
//  Created by mac on 1/13/21.
//

import SwiftUI

class MessageSMSViewController : UIViewController {
    
    //MARK: Properties

    var slideIdicator : UIView = {
        let view               = UIView()
        view.backgroundColor   = .lightGray
        view.constrainHeight(constant: 3)
        view.constrainWidth(constant: 85)
        return view
    }()
    private let describeText    = UITextView()
    private let texView         = UIView()
    private let sendButton      = UIButton(type : .system)
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        creatUI()
        dismissKeyBoard()
        setActions()
    }
    @objc func handleUpdate() {
        print("Its Sends")
    }
    private  func setupNextButton() {
        sendButton.backgroundColor = UIColor(Color.buttonsColor)
        sendButton.shadow(UIColor(Color.buttonsColor))
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = .verdana
        sendButton.constrainWidth(constant: 150)
        sendButton.layer.cornerRadius = 8
    }
    private func setupDescribeText() {
        texView.constrainHeight(constant: 200)
        texView.constrainWidth(constant: 150)
        texView.addSubview(describeText)
        describeText.fillSuperview()
        texView.layer.cornerRadius = 12
        texView.shadow()
        texView.backgroundColor = .tertiarySystemFill
        describeText.text = "Enter a Message Here..."
        describeText.font = .verdanaLight
        describeText.textColor = .systemGray
        describeText.constrainWidth(constant: 150)
        describeText.constrainHeight(constant: 200)
        describeText.layer.cornerRadius = 12
        describeText.delegate = self
        
    }
    fileprivate func creatUI() {
        setupDescribeText()
        setupNextButton()
        view.addSubview(slideIdicator)
        slideIdicator.translatesAutoresizingMaskIntoConstraints = false
        slideIdicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12).isActive = true
        slideIdicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        let vStack = VerticalStackView(arrangedSubviews: [texView,sendButton], spacing: 30)
        view.addSubview(vStack)
        vStack.anchor(top: slideIdicator.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(allInset: 25))
    }
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    fileprivate func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func setActions() {
        sendButton.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
    }
}
extension MessageSMSViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

        if describeText.textColor == UIColor.systemGray {
            describeText.text = ""
            describeText.textColor = .label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if describeText.text == "" {
            describeText.text = "Enter a Message Here..."
            describeText.textColor = UIColor.lightGray
        }
    }
}
