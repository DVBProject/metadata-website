# Metadata Section for the DVB Website

Recommended reading: [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)

## `metadata.xhtml`

This is the static page that will be hosted somewhere at
<https://dvb.org/metadata/>. It describes the contents of the
files in the `metadata` tree.

## `metadata`

This directory holds the tree of XML and JSON files which will be
accessible at <https://dvb.org/metadata/>.

The top level `catalog.xml`, and its siblings in the subdirectories
index all XML files in the tree (but not JSON), and are generated
using
[XML Catalog Builder](https://github.com/c-alpha/XMLCatalogBuilder). **Do
not edit these files.**

The subdirectories hold the current and historical versions of the XML
and JSON metadata definitions. Where redundancy occurs (e.g. a file
was not updated with a new release of the specification), symlinks are
used as appropriate. **Note well:** this implies that checking out a
copy of this repository on a client that does not support symlinks
**will not work.** If you push updates to the `metadata` tree from
such a client, **you will mess up the repository.** So for all good,
make sure you know what you're doing. ;-)

The catalog builder script expects a certain directory structure,
where XML files are only recognised at the third level of
subdirectories. Let's consider an example:

```
metadata/
+-- catalog.xml
+-- foo/
   +-- catalog.xml
   +-- first-schema.xsd        // BAD! Don't Do this.
   +-- bar/
       +-- second-schema.xsd
   +-- baz/
       +-- third-schema.xsd
```

Here, the `second-schema.xsd` and `third-schema.xsd` would be picked
up by the XML catalog builder script, but **not** `first-schema.xsd`.

## Maintainer Notes

Be mindful when regenerating `catalog.xml` files. There are DTDs in the
tree, and their identifiers have been added manually to the `catalog.xml`
files. Hence, after re-generating the catalogues using
[XML Catalog Builder](https://github.com/c-alpha/XMLCatalogBuilder), be sure
to discard the hunks with the DTD entries from the `catalog.xml` files before
committing them.

To get this onto the website, make a new release here. This will
trigger a web-hook, which will bring over the XML tree, and update the
static page content from `metadata.xhtml`.
