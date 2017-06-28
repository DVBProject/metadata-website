# New Metadata Section for the DVB Website

Recommended reading: [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)

## `featuretest`

This directory contains three files, which show what can be achieved
when pasting the raw HTML into the web page editor of the DVB
website's CMS:

- `featuretest.xhtml` is a sample document trying to exercise the
    basic layout features for static documents
- `featuretest.pdf` shows how `featuretest.xhtml` is rendered in my
    local browser (Opera)
- `featuretest-results.pdf` shows what the DVB website CMS makes of
    `featuretest.xhtml`

It seems that:

- normal flow text and outline levels works as expected
- but line breaks are significant (this means that lengthy text
    content, such as e.g. in a `<p>` or `<td>` element, must not
    contain any line breaks, but the entire element must be on a
    single line)
- bold, italics, and underline tags are **stripped**
- `<code>` tags are **stripped**
- links to fragments on the same page may not work (but further
    investigation needed)
- flat lists work as expected
- nested un-numbered lists work as expected
- nested lists involving numbered lists **don't work**
- having several `<p>` inside a list item **does not work** (due to a
    special `p:first-child` CSS rule)
- simple tables with and without captions work ok
- left/centre/right aligning text inside table cells works
- table header rows and header columns work
- table borders **don't work**
- table alignment **does not work** (tables are always stretched to
    100% width)
- merged/split cells in tables **don't work**
- `<div>` **doesn't work**
- `<section>` elements **are removed**, too

## `metadata.xhtml`

This is the static page that will be hosted somewhere at
<https://dvb.org/standards/>. Make sure you took the above listed
go/no-go feature list above into account before pushing updates. It
describes the contents of the files in the `metadata` tree.

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
