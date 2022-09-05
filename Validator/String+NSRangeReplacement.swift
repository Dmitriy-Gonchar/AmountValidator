//
//  String+NSRangeReplacement.swift
//  Validator
//
//  Created by Jesus++ on 06.09.2022.
//

import Foundation

extension String
{
	@inline(__always)
	func replacingCharacters<T>(in range: NSRange,
								with replacement: T) -> String? where T : StringProtocol
	{
		guard let range = Range(range, in: self) else { return nil }
		return self.replacingCharacters(in: range, with: replacement)
	}
}
