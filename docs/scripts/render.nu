#!/usr/bin/env nu

# Quick render script - can be run from docs directory
# Usage: nu scripts/render.nu

def main [] {
    print "🎨 Quick render of Typst examples..."

    # Ensure we're in the docs directory
    if not ("examples" | path exists) {
        print "❌ Please run this script from the docs directory"
        print "   Expected: nu scripts/render.nu"
        return
    }

    let output_dir = "public/examples"

    # Create output directories
    mkdir $output_dir
    mkdir ($output_dir | path join "wechat")
    mkdir ($output_dir | path join "discord")
    mkdir ($output_dir | path join "qqnt")

    # Render all examples
    let themes = ["wechat", "discord", "qqnt"]

    for theme in $themes {
        let theme_dir = ("examples" | path join $theme)

        if ($theme_dir | path exists) {
            print $"📱 Processing ($theme) examples..."

            let typ_files = (glob $"examples/($theme)/*.typ")

            for file in $typ_files {
                let basename = ($file | path basename | path parse | get stem)
                let output_file = ($output_dir | path join $theme $"($basename).svg")

                print $"   🔄 ($basename).typ -> ($basename).svg"

                try {
                    typst compile --format svg $file $output_file
                } catch {
                    print $"   ❌ Failed to render ($basename).typ"
                }
            }

            # Count rendered files
            let rendered = (glob $"public/examples/($theme)/*.svg" | length)
            print $"   ✅ Rendered ($rendered) files"
        }
    }

    print "🎉 All examples rendered!"
}
