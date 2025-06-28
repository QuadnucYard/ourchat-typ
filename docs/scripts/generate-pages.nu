#!/usr/bin/env nu

# Build script to generate individual example pages

# First get all examples
let examples = (ls examples/*/**.typ | each { |file|
    let parts = ($file.name | path parse)
    let theme = ($parts.parent | path basename)
    let name = $parts.stem
    {
        theme: $theme
        name: $name
        file: $file.name
    }
})

# Create gallery directory if it doesn't exist
mkdir gallery

# Read the detail.html template
let template = (open detail.html)

print $"Found ($examples | length) examples"

# For each example, create a static HTML file
for example in $examples {
    print $"Generating gallery/($example.name).html"

    # Create a simplified version - we'll use the build process to inject the actual data
    let output_file = $"gallery/($example.name).html"
    $template | save $output_file
}

print "Generated individual example HTML files"
print "Now run: bun run build"
