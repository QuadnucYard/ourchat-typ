/// Customer support conversation with professional styling

#import "../mod.typ": *

#show: example-style

#let support = user(name: [Support Team], title: [Technical Support], avatar: rect(
  fill: rgb("#2196F3"),
  radius: 50%,
  text(white, size: 8pt, weight: "bold")[🛠],
))

#let customer = user(name: [John Developer], title: [Customer], avatar: circle(
  fill: gradient.radial(gray.lighten(40%), gray),
  text(white, size: 8pt, weight: "bold")[JD],
))

#wechat.chat(
  theme: (
    inherit: "light",
    bubble-left: rgb("#E3F2FD"),
    bubble-right: rgb("#F3E5F5"),
    text-left: rgb("#1565C0"),
    text-right: rgb("#7B1FA2"),
  ),
  layout: (
    message-text-size: 11pt,
    bubble-inset: 0.8em,
  ),
  width: 450pt,

  time[Support Ticket #12345 - Today 10:00],

  message(right, customer)[
    Hi! I'm having trouble with the API authentication. Getting a 401 error.
  ],

  message(left, support)[
    Hello! I'd be happy to help you with the authentication issue.

    Could you please share the code you're using for the API request?
  ],

  message(right, customer)[
    Sure! Here's my code:

    ```javascript
    fetch('/api/data', {
      method: 'GET',
      headers: {
        'Authorization': 'Bearer my-token'
      }
    })
    ```
  ],

  message(left, support)[
    I see the issue! The token format should include "Bearer " prefix. Try this:

    ```javascript
    headers: {
      'Authorization': `Bearer ${your_actual_token}`
    }
    ```

    Also make sure your token hasn't expired (they're valid for 24 hours).
  ],

  message(right, customer)[
    Oh! I was using a placeholder. Let me try with the real token...

    It works now! Thank you so much! 🎉
  ],

  message(left, support)[
    Excellent! Glad we could resolve that quickly.

    Feel free to reach out if you have any other questions. Have a great day! ✨
  ],
)
