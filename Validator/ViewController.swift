//
//  ViewController.swift
//  Validator
//
//  Created by Jesus++ on 05.09.2022.
//

import UIKit

class ViewController: UIViewController, AmountValidatorDelegate
{
	@IBOutlet weak var textField: UITextField!
	var validator = AmountValidator()

	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.textField.delegate = self.validator
		self.validator.delegate = self
	}

	func changeText(in textField: UITextField)
	{
		if textField.text == "."
		{
			textField.text = "0."
		}
		else if textField.text == "00"
		{
			textField.text = "0"
		}

		print(textField.text ?? "")
	}
}
