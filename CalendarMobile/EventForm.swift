//
//  EventForm.swift
//  CalendarMobile
//
//  Created by C4Q on 6/20/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import UIKit

class EventForm: UIView {
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        return view
    }()
    
    let pickerViewStart: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .white
        picker.datePickerMode = .time
        return picker
    }()
    let pickerViewEnd: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .white
        picker.datePickerMode = .time
        return picker
    }()
    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        return button
    }()
    let descriptionTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 0.5
        return view
    }()
    let titleTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.placeholder = "Title"
        field.layer.borderWidth = 0.5
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .clear
        setupViews()
    }
    private func setupViews() {
        addSubview(containerView)
        views().forEach{self.addSubview($0)}
        setupContraints()
    }
    func views() -> [UIView] {
        let views = [pickerViewStart, pickerViewEnd, submitButton, descriptionTextView, titleTextField] as [UIView]
        return views
    }
    private func setupContraints() {
        let guide = self.safeAreaLayoutGuide
        views().forEach{($0).translatesAutoresizingMaskIntoConstraints = false}
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            ///ContainerView
            containerView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.6),
            containerView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            
            ///TextField
            titleTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            
            ///DescriptionView
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            descriptionTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: titleTextField.widthAnchor),
            descriptionTextView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3),
            
            ///PickerViews
            //Start
            pickerViewStart.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2),
            pickerViewStart.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            pickerViewStart.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pickerViewStart.widthAnchor.constraint(equalTo: descriptionTextView.widthAnchor),
            
            //End
            pickerViewEnd.heightAnchor.constraint(equalTo: pickerViewStart.heightAnchor),
            pickerViewEnd.topAnchor.constraint(equalTo: pickerViewStart.bottomAnchor, constant: 5),
            pickerViewEnd.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pickerViewEnd.widthAnchor.constraint(equalTo: descriptionTextView.widthAnchor),
            
            
            
            ///SubmitButton
//            submitButton.heightAnchor.constraint(equalToConstant: 20),
            submitButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            submitButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
            
            
            
            ])
    }

}
