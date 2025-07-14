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
    let items = ["typst.toml", "LICENSE", "src"]

    # Copy each item in the array
    for item in $items {
        try { cp -r -u $item $target_dir } catch { print $"No `($item)` to copy" }
    }

    print "Building README for universe..."

    build_readme $target_dir

    print $"Packaging complete. Files copied to ($target_dir)/"
    print "Package contents:"
    ls $target_dir
}

def build_readme [target_dir: string] {
    cd $target_dir

    # Copy README.typ to modify `is-universe-target`
    let readme_typ = "README.typ"
    open ../README.typ
        | str replace "#let is-universe-target = false" "#let is-universe-target = true"
        | save $readme_typ -f

    let readme_tmp = "README.tmp.md"
    let readme = "README.md"
    typlite README.typ $readme_tmp --assets-path assets --root (".." | path expand)
    nu "../scripts/fix-path-sep.nu" $readme_tmp $readme # Fix image slash in the README

    rm $readme_tmp
    rm $readme_typ
}
