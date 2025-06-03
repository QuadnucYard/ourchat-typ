#import "themes.typ"

/// Create a datetime item.
///
/// - body (content): The datetime body.
#let datetime(body) = {
  (kind: "datetime", body: body)
}

/// Create a message item.
///
/// - side: The message side (left | right).
/// - body (content): The message body.
/// - name (content): The name of sender.
/// - profile (content): The profile of sender.
/// - title (content): Title of the sender. Could be level (as in qqnt) or badges (as in discord)
/// - time (content): The time the message is sent, or will be sent.
/// - merge (bool): If this message will be merged with the previous message
#let message(side, body, name: none, profile: none, title: none, time: none, merge: false) = {
  (
    kind: "message",
    side: side,
    body: body,
    name: name,
    profile: profile,
    title: title,
    time: time,
    merge: merge,
  )
}

/// Create a plain item. Different from `message`, it does not have padding.
///
/// - side: The image side (left | right).
/// - body (content): The image body.
/// - name (content): The name of sender.
/// - profile (content): The profile of sender.
#let plain(side, body, name: none, profile: none) = {
  (kind: "plain", side: side, body: body, name: name, profile: profile)
}
