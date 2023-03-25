//
//  AssemblerFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 25/03/2023.
//

import Foundation
import Swinject

final class AssemblerFactory {
    static func make() -> Assembler {
        return Assembler(
                    [DefaultAssembly()],
                    parent: nil,
                    defaultObjectScope: .container
                )
    }
}
