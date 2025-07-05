#!/usr/bin/env nu

# Render all Typst examples to SVG format
# This script finds all .typ files in docs/examples/*/*.typ and renders them to public/examples/

def main [examples_dir: string, output_dir: string] {
    print "🎨 Rendering Typst examples to SVG..."

    print $"📁 Examples directory: ($examples_dir | path expand)"
    print $"📁 Output directory: ($output_dir | path expand)"


    # Ensure output directory exists
    mkdir $output_dir

    # Find all .typ files in theme subdirectories
    let typ_files = (
        ls $examples_dir
        | where type == dir
        | each { |theme_dir|
            ls $theme_dir.name
            | where type == file
            | where name =~ '\.typ$'
            | where name !~ 'mod\.typ$'
            | get name
        }
        | flatten
    )

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

    # Show summary - count SVG files in all theme directories
    let rendered_count = (
        ls $output_dir
        | where type == dir
        | each { |theme_dir|
            ls $theme_dir.name
            | where type == file
            | where name =~ '\.svg$'
            | length
        }
        | math sum
    )
    print $"📊 Total rendered files: ($rendered_count)"

    # List rendered files by theme
    for theme in ["wechat", "discord", "qqnt"] {
        let theme_path = ($output_dir | path join $theme)
        if ($theme_path | path exists) {
            let theme_files = (ls $theme_path | where type == file | where name =~ '\.svg$')
            if ($theme_files | length) > 0 {
                print $"   📱 ($theme): ($theme_files | length) files"
            }
        }
    }
}
