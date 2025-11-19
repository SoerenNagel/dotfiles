using Pkg
# using InteractiveUtils

function create_cache(cache_file)
        modules_to_search = [Base, Core]
        deps = Pkg.dependencies()
        for dep in values(deps)
                if dep.is_direct_dep
                        try
                                m = Base.require(Main, Symbol(dep.name))
                                push!(modules_to_search, m)
                        catch e
                        end
                end
        end

        # get all the function names
        function_list = String[]
        for modul in unique(modules_to_search)
                try
                        for name in names(modul)
                                push!(function_list, "$(modul).$(name)")
                        end
                catch e
                end
        end
        write(cache_file, join(function_list, "\n"))
end

path = ARGS[1]
create_cache(path)


