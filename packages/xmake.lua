package("xmake-project")
    set_description("A C/C++ Project Template Powered By Xmake.")

    add_urls("https://github.com/user/release/download/v$(version)/xmake-project-$(version)-$(plat)-$(arch).tar.gz")
    add_versions("1.1.0", "sha256...")

    on_install(function(package)
        os.cp("config",package:installdir())
        os.cp("include",package:installdir())
        os.cp("lib",package:installdir())
    end)
