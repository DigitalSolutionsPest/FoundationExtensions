import Foundation
import FoundationExtensions
import Testing

struct CalendarExtensionsTests {
  private let iso8601 = ISO8601DateFormatter()

  @Test
  func localDayFromUTCInstant_matchesSameUTCDay() throws {
    var calendar = Calendar(identifier: .gregorian)

    let midnight = try #require(iso8601.date(from: "2024-06-15T00:00:00Z"))
    let morning = try #require(iso8601.date(from: "2024-06-15T08:30:00Z"))
    let evening = try #require(iso8601.date(from: "2024-06-15T23:59:59Z"))
    let nextDay = try #require(iso8601.date(from: "2024-06-16T00:00:00Z"))

    // America/New_York (EDT in June)
    calendar.timeZone = try #require(TimeZone(identifier: "America/New_York"))
    var day = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 15)))
    var next = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 16)))
    #expect(calendar.localDay(fromUTCInstant: midnight) == day)
    #expect(calendar.localDay(fromUTCInstant: morning) == day)
    #expect(calendar.localDay(fromUTCInstant: evening) == day)
    #expect(calendar.localDay(fromUTCInstant: nextDay) == next)

    // America/Los_Angeles (PDT in June)
    calendar.timeZone = try #require(TimeZone(identifier: "America/Los_Angeles"))
    day = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 15)))
    next = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 16)))
    #expect(calendar.localDay(fromUTCInstant: midnight) == day)
    #expect(calendar.localDay(fromUTCInstant: morning) == day)
    #expect(calendar.localDay(fromUTCInstant: evening) == day)
    #expect(calendar.localDay(fromUTCInstant: nextDay) == next)

    // Australia/Adelaide (ACST, UTC+9:30 in June)
    calendar.timeZone = try #require(TimeZone(identifier: "Australia/Adelaide"))
    day = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 15)))
    next = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 16)))
    #expect(calendar.localDay(fromUTCInstant: midnight) == day)
    #expect(calendar.localDay(fromUTCInstant: morning) == day)
    #expect(calendar.localDay(fromUTCInstant: evening) == day)
    #expect(calendar.localDay(fromUTCInstant: nextDay) == next)

    // Pacific/Marquesas (UTC−9:30, no DST)
    calendar.timeZone = try #require(TimeZone(identifier: "Pacific/Marquesas"))
    day = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 15)))
    next = try #require(calendar.date(from: .init(year: 2024, month: 6, day: 16)))
    #expect(calendar.localDay(fromUTCInstant: midnight) == day)
    #expect(calendar.localDay(fromUTCInstant: morning) == day)
    #expect(calendar.localDay(fromUTCInstant: evening) == day)
    #expect(calendar.localDay(fromUTCInstant: nextDay) == next)
  }

  @Test
  func localDayFromUTCInstant_nilInputReturnsNil() {
    #expect(Calendar.current.localDay(fromUTCInstant: nil) == nil)
  }
}
