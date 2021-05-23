-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
return {
    cmd = { "svelteserver", "--stdio" },
    filetypes = { "svelte", "svx" },
    rootMarkers = { "package.json", ".git" },
}
