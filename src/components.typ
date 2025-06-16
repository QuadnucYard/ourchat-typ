
/// Create a time item.
///
/// - body (content): The time body.
#let time(body) = {
  (kind: "time", body: body)
}

/// Create a message item.
///
/// - side: The message side (left | right).
/// - user: The message sender.
/// - body (content): The message body.
/// - time (content): The time the message is sent, or will be sent.
/// - merge (bool): If this message will be merged with the previous message
#let message(side, user, body, time: none, merge: false) = {
  (
    kind: "message",
    side: side,
    user: user,
    body: body,
    time: time,
    merge: merge,
  )
}

#let free-message(body, time: none, merge: false) = {
  (
    kind: "message",
    body: body,
    time: time,
    merge: merge,
  )
}

/// Create a plain item. Different from `message`, it does not have padding.
///
/// - side: The image side (left | right).
/// - user: The message sender.
/// - body (content): The image body.
/// - name (content): The name of sender.
/// - profile (content): The profile of sender.
#let plain(side, user, body) = {
  (kind: "plain", side: side, user: user, body: body)
}

#let user(name: none, profile: none, title: none) = {
  (
    name: name,
    profile: profile,
    title: title,
  )
}

#let with-side-user(side, user, ..messages) = {
  messages
    .pos()
    .map(msg => if msg.kind == "message" {
      msg.side = side
      msg.user = user
      msg
    } else {
      msg
    })
}
