set shell := ["nu", "-c"]

export TYPST_ROOT := justfile_directory()


default:
  @just --list

test:
  tinymist test --root . tests/test-validation.typ

package target="out":
  nu scripts/package.nu {{target}}
