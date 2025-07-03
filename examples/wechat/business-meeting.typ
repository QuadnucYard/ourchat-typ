/// [Featured]
/// Professional team meeting discussion showcasing business communication

#import "../mod.typ": *

#show: example-style

#let manager = user(name: [Sarah Chen], title: [Project Manager], avatar: rect(
  fill: blue.darken(20%),
  text(white, size: 8pt, weight: "bold")[SM],
))

#let dev1 = user(name: [Alex Kim], title: [Senior Developer], avatar: rect(
  fill: green.darken(20%),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[AK],
))

#let dev2 = user(name: [Emma Wilson], title: [Frontend Dev], avatar: rect(
  fill: purple.darken(20%),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[EW],
))

#wechat.chat(
  theme: "dark",
  layout: (
    content-width: 480pt,
    avatar-size: 36pt,
    message-text-size: 12pt,
    bubble-radius: 6pt,
    row-gutter: 0.8em,
  ),
  time[Monday 9:00 AM],

  message(left, manager)[
    Good morning team! Let's review our sprint progress:

    #table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + gray,
      inset: 6pt,
      [*Feature*], [*Status*], [*Due Date*],
      [User Authentication], [✅ Complete], [Last Friday],
      [Dashboard UI], [🔄 In Progress], [This Wednesday],
      [API Integration], [📅 Planned], [Next Monday],
      [Mobile Responsive], [📅 Planned], [Next Friday],
    )
  ],

  message(right, dev1)[
    Thanks Sarah! The dashboard is about 75% complete.

    Just need to finish the data visualization charts and we'll be ready for QA testing.
  ],

  message(left, dev2)[
    I can help with the mobile responsive part once the dashboard is done.

    Should we schedule a design review session?
  ],

  message(left, manager)[
    Great idea! Let's meet Wednesday at 2 PM to review the dashboard.

    *Action Items:*
    - Alex: Finish dashboard by Tuesday EOD
    - Emma: Prepare mobile mockups
    - Sarah: Schedule QA testing slot
  ],

  message(right, dev1)[
    Sounds good! I'll push the latest changes to the staging branch by tomorrow morning.
  ],

  message(right, dev2)[
    Perfect! I'll have the mobile wireframes ready for our Wednesday meeting. 📱
  ],
)
