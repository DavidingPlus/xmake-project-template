if not get_config("with_gtest") then
    return
end

target("gtest-xmake-project")
    set_default(false)
    set_kind("binary")
    set_targetdir("$(builddir)/test")
    add_files("*.cpp")
    add_deps("xmake-project")
    add_packages("gtest")
    apply_current_platform_target_config()
target_end()

target("tests")
    set_default(false)
    set_kind("phony")
    add_deps("gtest-xmake-project")
target_end()
