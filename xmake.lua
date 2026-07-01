set_project ("XMake Project")
set_version ("0.0.0")
set_description ("C/C++ 项目的 xmake 模板")
set_languages ("cxx17")


-- print (project.version())

-- -- 生成 .version 文件。
-- io.writefile(
--     path.join("$(builddir)", ".version"),
--     project.version()
-- )

target("xmake-project")

    set_kind("static")
    add_files("src/*.cpp")
    set_targetdir("$(builddir)/lib")
    add_cxflags("/utf-8")

target_end()
