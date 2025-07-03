/// Simple Discord theme

#import "../mod.typ": *

#show: example-style

#discord.chat(
  layout: (content-width: 400pt),
  oc.time[Today at 3:30 PM],
  oc.message(left, alice, time: [Today at 3:30 PM])[
    Welcome to our Discord-style chat!
  ],
  oc.message(
    left,
    discord.newbie-user(name: [Charlie], avatar: alice.avatar),
    time: [Today at 3:31 PM],
  )[
    Thanks! This looks just like Discord.
  ],
  oc.message(left, bob, time: [Today at 3:32 PM])[
    You can even add custom titles and timestamps!
  ],
)
