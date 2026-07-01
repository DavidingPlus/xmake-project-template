function add_public_headers()
    local seen = {}

    for _, header in ipairs(os.files("src/**.h")) do
        local relative = path.relative(header, "src")
        local topmodule, _ = relative:match("^([^/\\]+)[/\\](.+)$")
        local filename = path.filename(header)
        local installkey = (topmodule and (topmodule .. "/") or "") .. filename

        if seen[installkey] then
            raise("duplicate public header install path: %s from %s and %s", installkey, seen[installkey], header)
        end
        seen[installkey] = header

        if topmodule then
            -- Example:
            --   src/foo/bar/baz.h -> include/foo/baz.h
            --   src/foo/bar.h     -> include/foo/bar.h
            add_headerfiles(header, {prefixdir = topmodule, filename = filename})
        else
            -- Example:
            --   src/foo.h -> include/foo.h
            add_headerfiles(header, {filename = filename})
        end
    end
end
