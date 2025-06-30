#import "src/lib.typ" as oc
#import oc.themes: *

// Test 1: Valid theme and layout (should work)
#let test-validate-theme() = {
  wechat.chat(theme: (bubble-left: rgb("#ffcccc")), layout: (content-width: 300pt), oc.message(
    left,
    wechat.default-user(name: [Test]),
  )[Valid message])
}

// Test 2: Invalid theme field (should cause panic)
#let panic-on-invalid-theme-field() = {
  wechat.chat(theme: (invalid-field: rgb("#ffcccc")), oc.message(
    left,
    wechat.default-user(name: [Test]),
  )[Invalid theme field])
}

// Test 3: Invalid layout field (should cause panic)
#let panic-on-invalid-layout-field() = {
  wechat.chat(layout: (invalid-layout-field: 300pt), oc.message(
    left,
    wechat.default-user(name: [Test]),
  )[Invalid layout field])
}

// Test 4: Validation disabled (should work even with invalid fields)
#let test-validation-disabled() = {
  wechat.chat(
    theme: (invalid-field: rgb("#ffcccc")),
    layout: (invalid-layout-field: 300pt),
    validate: false,
    oc.message(left, wechat.default-user(name: [Test]))[Validation disabled - no error],
  )
}
