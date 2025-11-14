import Foundation
import Translation

enum AppLanguage: String, CaseIterable, Identifiable {
    case englishUS        = "English (US)"
    case englishUK        = "English (UK)"
    case spanishSpain     = "Spanish (Spain)"
    case italian          = "Italian"
    case french           = "French"
    case german           = "German"
    case portugueseBR     = "Portuguese (Brazil)"
    case russian          = "Russian"
    case arabic           = "Arabic"
    case chineseSimplified  = "Chinese (Simplified)"
    case chineseTraditional = "Chinese (Traditional)"
    case japanese         = "Japanese"
    case korean           = "Korean"
    case dutch            = "Dutch"
    case indonesian       = "Indonesian"
    case thai             = "Thai"
    case turkish          = "Turkish"
    case vietnamese       = "Vietnamese"
    case ukrainian        = "Ukrainian"
    case hindi            = "Hindi"

    var id: String { rawValue }
    var displayName: String { rawValue }

    /// For Translation framework
    var localeLanguage: Locale.Language {
        switch self {
        case .englishUS:          return .init(identifier: "en-US")
        case .englishUK:          return .init(identifier: "en-GB")
        case .spanishSpain:       return .init(identifier: "es-ES")
        case .italian:            return .init(identifier: "it")
        case .french:             return .init(identifier: "fr")
        case .german:             return .init(identifier: "de")
        case .portugueseBR:       return .init(identifier: "pt-BR")
        case .russian:            return .init(identifier: "ru")
        case .arabic:             return .init(identifier: "ar")
        case .chineseSimplified:  return .init(identifier: "zh-Hans")
        case .chineseTraditional: return .init(identifier: "zh-Hant")
        case .japanese:           return .init(identifier: "ja")
        case .korean:             return .init(identifier: "ko")
        case .dutch:              return .init(identifier: "nl")
        case .indonesian:         return .init(identifier: "id")
        case .thai:               return .init(identifier: "th")
        case .turkish:            return .init(identifier: "tr")
        case .vietnamese:         return .init(identifier: "vi")
        case .ukrainian:          return .init(identifier: "uk")
        case .hindi:              return .init(identifier: "hi")
        }
    }
}
