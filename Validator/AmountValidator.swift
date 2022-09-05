//
//  AmountValidator.swift
//  Validator
//
//  Created by Jesus++ on 06.09.2022.
//

import UIKit

protocol AmountValidatorDelegate: AnyObject
{
	func changeText(in textField: UITextField)
}

class AmountValidator: NSObject, UITextFieldDelegate
{
	weak var delegate: AmountValidatorDelegate?

	func textField(_ textField: UITextField,
				   shouldChangeCharactersIn range: NSRange,
				   replacementString string: String) -> Bool
	{
		// after manipulation call:
		if textField.allTargets.count == 0
		{
			textField.addTarget(self,
								action: #selector(textFieldDidChange),
								for: .editingChanged)
		}

		// original string before manipulation:
		let old = textField.text ?? ""

		// original string without thousand separators:
		let plainOld = old.replacingOccurrences(of: ",", with: "")

		// if there is already a separator and we enter a new one:
		if Double(plainOld) != nil && Int(plainOld) == nil && string == ","
		{
			//decimal separator must be one:
			return false
		}

		let replacement = string == "," ? "." : string

		let new = old
			.replacingCharacters(in: range, with: replacement) ?? ""

		if replacement == "."
		{
			if new.components(separatedBy: ".").count > 2
			{
				return false
			}
			// forced replacement of the separator from dot to comma:
			textField.text = new
			self.textFieldDidChange(textField)
			return false
		}

		let compo = new.components(separatedBy: ".")

		if new.isEmpty
		{
			return true
		}

		if compo.count == 2
		{
			if compo[1].count < 3,
			   Int(compo[1]) != nil || compo[1] == ""
			{
				return true
			}
			else
			{
				return false
			}
		}
		else if Double(new) != nil
		{
			return true
		}
		return false
	}

	@objc func textFieldDidChange(_ textField: UITextField)
	{
		self.delegate?.changeText(in: textField)
	}
}
