#import "../src/lib.typ" as oc
#import "../src/utils.typ": *


= Simplified Theme Utility Functions Demo

== Using `resolve-theme` with fallback

```typst
// Example theme collection
#let my-themes = (
  ocean: (
    bg-color: blue.lighten(90%),
    text-color: blue.darken(80%),
    bubble-color: blue.lighten(60%),
  ),
  sunset: (
    bg-color: orange.lighten(90%),
    text-color: red.darken(60%),
    bubble-color: orange.lighten(40%),
  ),
  forest: (
    bg-color: green.lighten(90%),
    text-color: green.darken(80%),
    bubble-color: green.lighten(60%),
  ),
)

// Resolve theme by name
#let ocean-theme = resolve-theme(my-themes, "ocean", default: "forest")
#ocean-theme

// Resolve with fallback (invalid theme name)
#let fallback-theme = resolve-theme(my-themes, "invalid", default: "ocean")
#fallback-theme

// Resolve custom theme (no inherit field)
#let custom-theme = resolve-theme(my-themes, (
  bg-color: purple.lighten(90%),
  text-color: purple.darken(80%),
  bubble-color: purple.lighten(60%),
), default: "forest")
#custom-theme
```

== Theme inheritance with fallback

```typst
// Custom theme inheriting from existing theme
#let inherited-theme = resolve-theme(
  my-themes,
  (
    inherit: "ocean",
    bubble-color: red.lighten(80%),  // Override bubble color
  ),
  default: "forest"  // Fallback if "ocean" doesn't exist
)

Result: #inherited-theme

// Invalid inherit with fallback
#let invalid-inherit = resolve-theme(
  my-themes,
  (
    inherit: "nonexistent",
    bubble-color: yellow,
  ),
  default: "sunset"  // Will use sunset as base instead
)

Fallback result: #invalid-inherit
```

== Using `validate-theme`

```typst
// Validate that a theme has required fields
#let required-fields = ("bg-color", "text-color", "bubble-color")

// This will work
#let valid-theme = validate-theme((
  bg-color: white,
  text-color: black,
  bubble-color: gray,
  extra-field: "optional",
), required-fields)

Valid theme: #valid-theme

// This would panic (uncomment to test):
// #validate-theme((bg-color: white), required-fields)
```

== Complete Theme Resolution Workflow

Here's how you might use the simplified utility in a theme system:

```typst
#let wechat-themes = (
  light: (
    bg-color: white,
    text-color: black,
    bubble-color: gray.lighten(80%),
    accent-color: blue,
  ),
  dark: (
    bg-color: black,
    text-color: white,
    bubble-color: gray.darken(60%),
    accent-color: blue.lighten(40%),
  ),
)

#let theme-system(user-theme) = {
  // Single function handles everything with fallback
  let resolved = resolve-theme(wechat-themes, user-theme, default: "light")

  // Validate the final theme
  validate-theme(resolved, ("bg-color", "text-color"))
}

// Examples:
#let example1 = theme-system("dark")
#let example2 = theme-system((inherit: "dark", accent-color: green))
#let example3 = theme-system((bg-color: yellow, text-color: black))
#let example4 = theme-system("invalid-theme")  // Uses "light" fallback

Example 1 (string): #example1
Example 2 (inherit): #example2
Example 3 (custom): #example3
Example 4 (fallback): #example4
```
