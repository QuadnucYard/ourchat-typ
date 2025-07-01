#!/usr/bin/env nu

# Render all Typst examples to SVG format
# This script finds all .typ files in docs/examples/*/*.typ and renders them to public/examples/

def main [] {
    print "🎨 Rendering Typst examples to SVG..."

    # Get the docs directory (parent of scripts)
    let docs_dir = ($env.FILE_PWD | path dirname)
    let examples_dir = ($docs_dir | path dirname | path join "examples")
    let output_dir = ($docs_dir | path join "public" "examples")

    print $"📁 Examples directory: ($examples_dir)"
    print $"📁 Output directory: ($output_dir)"

    cd $docs_dir
    # Ensure output directory exists
    mkdir $output_dir

    # Find all .typ files in theme subdirectories
    let typ_files = glob $"../examples/*/*.typ" -e ["**/mod.typ"]

    if ($typ_files | length) == 0 {
        print "❌ No .typ files found in examples directory"
        return
    }

    print $"📋 Found ($typ_files | length) example files"

    # Process each .typ file
    $typ_files | par-each { |file|
        let rel_path = ($file | path relative-to $examples_dir)
        let theme = ($rel_path | path dirname)
        let basename = ($rel_path | path basename | path parse | get stem)

        # Create theme output directory
        let theme_output_dir = ($output_dir | path join $theme)
        mkdir $theme_output_dir

        # Output SVG path
        let svg_path = ($theme_output_dir | path join $"($basename).svg")

        print $"🔄 Rendering ($theme)/($basename).typ..."

        # Render with typst
        try {
            typst compile --format svg $file $svg_path --root ..
            print $"✅ Rendered ($svg_path)"
        } catch {
            print $"❌ Failed to render ($file)"
            print $"   Error: ($env.LAST_EXIT_CODE)"
        }
    }

    print "🎉 Rendering complete!"

    # Show summary
    let rendered_files = (glob "public/examples/*/*.svg")
    print $"📊 Total rendered files: ($rendered_files | length)"

    # List rendered files by theme
    for theme in ["wechat", "discord", "qqnt"] {
        let theme_files = (glob $"public/examples/($theme)/*.svg")
        if ($theme_files | length) > 0 {
            print $"   📱 ($theme): ($theme_files | length) files"
        }
    }
}
