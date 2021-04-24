import Foundation

final class Option {
    
    let design: Design
    
    init(design: Design) {
        self.design = design
    }
    
    static let all: [Option] = {
        return Design.allCases.map(Option.init)
    }()
}
