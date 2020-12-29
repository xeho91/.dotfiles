module.exports = {
	// https://htmlhint.com/docs/user-guide/list-rules

	// Doctype and Head
	"doctype-first": true,
	"doctype-html5": true,
	"head-script-disabled": false,
	"style-disabled": false,
	"title-require": true,

	// Attributes
	"attr-lowercase": true,
	"attr-no-duplication": true,
	"attr-no-unnecessary-whitespace": true,
	"attr-unsafe-chars": true,
	"attr-value-double-quotes": true,
	"attr-value-not-empty": false,
	"alt-require": true,
	"input-requires-label": true,

	// Tags
	"tags-check": true,
	"tag-pair": true,
	"tag-self-close": true,
	"tagname-lowercase": true,
	"empty-tag-not-self-closed": true,
	"src-not-empty": true,
	"href-abs-or-rel": "abs",

	// Id
	"id-class-ad-disabled": true,
	"id-class-value": false,
	"id-unique": true,

	// Inline
	"inline-script-disabled": false,
	"inline-style-disabled": false,

	// Formatting
	"space-tab-mixed-disabled": false,
	"spec-char-escape": true,
};
