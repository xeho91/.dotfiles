-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
return {
    cmd = { "svelteserver", "--stdio" },
    filetypes = { "svelte" },
    rootMarkers = { "package.json", ".git" },
}
