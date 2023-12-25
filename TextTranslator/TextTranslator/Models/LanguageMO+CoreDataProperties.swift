//
//  LanguageMO+CoreDataProperties.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//
//

import Foundation
import CoreData


extension LanguageMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LanguageMO> {
        return NSFetchRequest<LanguageMO>(entityName: "LanguageMO")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?

}

extension LanguageMO : Identifiable {

}
