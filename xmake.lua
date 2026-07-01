includes("config.lua")


local package_version = "0.0.0"


set_xmakever("3.0.9")
set_project("XMake Project")
set_description("A C/C++ project template powered by xmake.")
set_languages("cxx17")
set_version(package_version)
add_rules("mode.debug", "mode.release")


option("package_version")
    set_default("0.0.0")
    set_showmenu(true)
    set_description("Set the package version written to build/.version.")
option_end()

option("with_gtest")
    set_default(false)
    set_showmenu(true)
    set_description("Enable GoogleTest-based unit tests.")
option_end()

option("install_in_place")
    set_default(true)
    set_showmenu(true)
    set_description("Install to $(builddir)/install by default.")
option_end()

option("build_shared")
    set_default(default_build_shared_for_current_platform())
    set_showmenu(true)
    set_description("Build the template library as a shared library.")
option_end()


define_current_platform_options()

local build_shared = get_config("build_shared")

if build_shared == nil then
    build_shared = default_build_shared_for_current_platform()
end

if get_config("with_gtest") then
    add_requires("gtest")
end

target("xmake-project")
    set_kind(build_shared and "shared" or "static")
    if build_shared and is_current_win32() then
        add_rules("utils.symbols.export_all")
    end

    set_targetdir("$(builddir)/$(plat)/$(arch)/$(mode)/lib/")

    add_files("src/*.cpp")
    add_headerfiles(get_public_headers())
    add_includedirs("src", {public = true})
    add_installfiles("$(builddir)/$(plat)/$(arch)/$(mode)/.version")

    before_build(function (target)
        io.writefile(path.join(path.directory(target:targetdir()), ".version"), package_version)
    end)

    before_install(function (target)
        io.writefile(path.join(path.directory(target:targetdir()), ".version"), package_version)
    end)

    apply_current_platform_target_config()
target_end()


includes("snippet")

includes("test")
