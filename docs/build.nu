#!/usr/bin/env nu

# Build documentation for ourchat examples
# This script compiles all examples to SVG and generates HTML pages

def main [] {
    print "🚀 Building ourchat documentation..."

    # Create output directories
    mkdir docs/dist/examples/wechat
    mkdir docs/dist/examples/discord
    mkdir docs/dist/examples/qqnt
    mkdir docs/dist/html

    # Compile all examples to SVG
    compile_examples

    # Generate HTML pages
    generate_html_pages

    print "✅ Documentation build complete!"
    print $"📁 Output: (pwd)/docs/dist/"
}

# Compile all .typ examples to SVG
def compile_examples [] {
    print "📝 Compiling examples to SVG..."

    # WeChat examples
    let wechat_examples = (ls docs/examples/wechat/*.typ | get name)
    for example in $wechat_examples {
        let basename = ($example | path basename | str replace ".typ" "")
        let output = $"docs/dist/examples/wechat/($basename).svg"

        print $"  Compiling ($example) -> ($output)"
        ^typst compile $example $output --format svg
    }

    # Discord examples
    let discord_examples = (ls docs/examples/discord/*.typ | get name)
    for example in $discord_examples {
        let basename = ($example | path basename | str replace ".typ" "")
        let output = $"docs/dist/examples/discord/($basename).svg"

        print $"  Compiling ($example) -> ($output)"
        ^typst compile $example $output --format svg
    }

    # QQNT examples
    let qqnt_examples = (ls docs/examples/qqnt/*.typ | get name)
    for example in $qqnt_examples {
        let basename = ($example | path basename | str replace ".typ" "")
        let output = $"docs/dist/examples/qqnt/($basename).svg"

        print $"  Compiling ($example) -> ($output)"
        ^typst compile $example $output --format svg
    }
}

# Generate HTML pages from templates and example data
def generate_html_pages [] {
    print "🌐 Generating HTML pages..."

    # Extract example metadata
    let examples = extract_example_metadata

    # Generate gallery page
    generate_gallery_page $examples

    # Generate detail pages for each example
    for example in $examples {
        generate_detail_page $example
    }
}

# Extract metadata from example files
def extract_example_metadata [] {
    print "🔍 Extracting example metadata..."

    mut examples = []

    # Process each theme directory
    for theme in [wechat discord qqnt] {
        let theme_dir = $"docs/examples/($theme)"

        if ($theme_dir | path exists) {
            let example_files = (ls $"($theme_dir)/*.typ" | get name)

            for file in $example_files {
                let basename = ($file | path basename | str replace ".typ" "")
                let content = (open $file)

                # Extract documentation comments (lines starting with ///)
                let doc_lines = ($content | lines | where $it =~ '^///' | each { |line| $line | str replace '^/// ?' '' })

                let example = {
                    theme: $theme,
                    name: $basename,
                    title: ($basename | str replace '-' ' ' | str title-case),
                    file_path: $file,
                    svg_path: $"docs/dist/examples/($theme)/($basename).svg",
                    description: ($doc_lines | get 0? | default ""),
                    features: ($doc_lines | get 1? | str replace '^Features: ?' '' | default ""),
                    layout: ($doc_lines | get 2? | str replace '^Layout: ?' '' | default ""),
                    source_code: $content
                }

                $examples = ($examples | append $example)
            }
        }
    }

    return $examples
}

# Generate the gallery HTML page
def generate_gallery_page [examples] {
    print "📄 Generating gallery page..."

    # Read template
    let template = (open docs/html/gallery.html)

    # For now, copy template as-is (in a real implementation, you'd replace placeholders)
    $template | save docs/dist/html/gallery.html

    print "  ✅ Gallery page generated"
}

# Generate detail page for a specific example
def generate_detail_page [example] {
    print $"📄 Generating detail page for ($example.theme)/($example.name)..."

    # Read template
    let template = (open docs/html/detail.html)

    # Replace placeholders with actual example data
    let filled_template = ($template
        | str replace 'Simple Chat' $example.title
        | str replace 'wechat/simple-chat' $"($example.theme)/($example.name)"
        | str replace 'A basic casual conversation.*?' $example.description
    )

    # Save to output directory
    let output_path = $"docs/dist/html/($example.theme)-($example.name).html"
    $filled_template | save $output_path

    print $"  ✅ Detail page: ($output_path)"
}

# Clean build artifacts
def "main clean" [] {
    print "🧹 Cleaning build artifacts..."

    if (docs/dist | path exists) {
        rm -rf docs/dist
    }

    print "✅ Clean complete!"
}

# Serve the documentation locally
def "main serve" [--port: int = 8000] {
    print $"🌐 Starting local server on port ($port)..."
    print $"📁 Serving: (pwd)/docs/dist/"
    print $"🔗 Open: http://localhost:($port)/html/gallery.html"

    cd docs/dist
    ^python -m http.server $port
}

# Watch for changes and rebuild automatically
def "main watch" [] {
    print "👀 Watching for changes..."
    print "Press Ctrl+C to stop"

    # Initial build
    main

    # Watch for changes (simplified - real implementation would use a proper file watcher)
    loop {
        sleep 2sec

        # Check if any .typ files changed (this is a simplified check)
        let last_build = (stat docs/dist | get modified)
        let latest_typ = (ls docs/examples/**/*.typ | get modified | math max)

        if $latest_typ > $last_build {
            print "🔄 Changes detected, rebuilding..."
            main
        }
    }
}
