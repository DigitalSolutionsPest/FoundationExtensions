import Foundation

extension Calendar {
  /// Returns a calendar date representing the UTC calendar day of an absolute instant.
  ///
  /// The instant is interpreted in the Gregorian calendar with the GMT time zone; only the
  /// year, month, and day are taken. Those components are then used with this calendar to
  /// build a `Date` suitable for APIs such as `startOfDay(for:)`, so the “day” matches the
  /// server’s UTC date regardless of the device’s local time zone.
  ///
  /// Typical use: server payloads that carry a UTC calendar day, shown in the UI without
  /// the device time zone changing which day the user sees.
  ///
  /// - Parameters:
  ///   - date: An absolute instant, typically encoded as UTC from a remote source.
  public func localDay(fromUTCInstant date: Date?) -> Date? {
    guard let date else { return nil }
    var utcCalendar = Calendar(identifier: .gregorian)
    utcCalendar.timeZone = .gmt
    let utcDate = utcCalendar.dateComponents([.year, .month, .day], from: date)
    return self.date(from: utcDate)
  }
}
