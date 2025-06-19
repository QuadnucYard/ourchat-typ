


/// Validate that a theme dictionary contains required fields
///
/// - theme (dictionary): Theme to validate
/// - required-fields (array): List of required field names
/// -> dictionary: The theme (unchanged, for chaining)
#let validate-theme(theme, required-fields) = {
  for field in required-fields {
    if field not in theme {
      panic("Theme is missing required field: " + field)
    }
  }
  theme
}

/// Resolve a theme from a theme collection
///
/// This function takes a theme collection (dictionary of named themes) and a theme specifier,
/// and returns the resolved theme dictionary with fallback support.
///
/// - themes (dictionary): Collection of named themes
/// - theme (str, dictionary): Theme name or custom theme dictionary
/// - default (str): Default theme key to use as fallback if theme is invalid
/// -> dictionary: The resolved theme
#let resolve-theme(themes, theme, default: none) = {
  if theme == auto {
    theme = default
  }
  if type(theme) == str {
    // theme is a string - pick it from themes collection
    if theme in themes {
      themes.at(theme)
    } else if default != none and default in themes {
      // Invalid theme name, use default fallback
      themes.at(default)
    } else {
      panic(
        "Theme '"
          + theme
          + "' not found in theme collection. Available themes: "
          + repr(themes.keys()),
      )
    }
  } else if type(theme) == dictionary {
    // theme is a dictionary - handle inheritance or return directly
    if "inherit" in theme {
      // Handle inheritance
      let inherit-from = theme.inherit
      let base-theme = if type(inherit-from) == str and inherit-from in themes {
        themes.at(inherit-from)
      } else {
        panic("Invalid inherit value '" + repr(inherit-from) + "' and no valid default provided")
      }

      // Remove inherit field and merge with base theme
      let _ = theme.remove("inherit")
      base-theme + theme
    } else {
      // No inherit field, return custom theme directly
      theme
    }
  } else {
    panic(
      "Theme must be either a string (theme name) or dictionary (custom theme). Got: "
        + str(type(theme)),
    )
  }
}
