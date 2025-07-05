#!/usr/bin/env nu

# Package the library
# Use out/ as the default target directory, or use the first argument if provided

def main [target_dir: string = "out"] {
    print $"Packaging to ($target_dir)..."

    # If the target directory exists, remove its contents; otherwise, create it
    if ($target_dir | path exists) {
        rm -rf $"($target_dir)/*"
    } else {
        mkdir $target_dir
    }

    # List of files and directories to copy
    let items = ["typst.toml", "LICENSE", "README.md", "src", "assets"]

    # Copy each item in the array
    for item in $items {
        try { cp -r -u $item $target_dir } catch { print $"No `($item)` to copy" }
    }

    print $"Packaging complete. Files copied to ($target_dir)/"
    print "Package contents:"
    ls $target_dir
}
