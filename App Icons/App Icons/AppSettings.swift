//
//  AppSettings.swift
//  App Icons
//

import Foundation
import SwiftUI

public final class AppSettings: ObservableObject {

  @Published public var iconIndex: Int = 0

  public private(set) var icons: [Icon] = []
  public var currentIconName: String? {
    UIApplication.shared.alternateIconName
  }

  public init() {
    fetchIcons()
  }

  private func fetchIcons() {
    if let bundleIcons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any]
    {
      // Default Icon
      if let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
         let iconFileName = (primaryIcon["CFBundleIconFiles"] as? [String])?.first {
        let displayName = (primaryIcon["CFBundleIconName"] as? String) ?? ""
        // To reset to the default icon, we call setAlternateIconName with nil, so we create an
        // icon object with nil as its icon name
        icons.append(
          Icon(displayName: displayName, iconName: nil, image: UIImage(named: iconFileName))
        )
      }

      // Alternate Icons
      if let alternateIcons = bundleIcons["CFBundleAlternateIcons"] as? [String: Any] {
        alternateIcons.forEach { iconName, iconInfo in
          if let iconInfo = iconInfo as? [String: Any],
             let iconFileName = (iconInfo["CFBundleIconFiles"] as? [String])?.first
          {
            icons.append(
              Icon(displayName: iconName, iconName: iconName, image: UIImage(named: iconFileName))
            )
          }
        }
      }
    }

    iconIndex = icons.firstIndex(where: { icon in
      return icon.iconName == currentIconName
    }) ?? 0
  }
}

public struct Icon {
  public let displayName: String
  public let iconName: String?
  public let image: UIImage?
}
