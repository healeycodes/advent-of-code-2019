filename = ARGS[1]
input = readlines(filename)
orbits = Dict()
for orbit in input
    planet, moon = split(orbit, ')')
    orbits[String(moon)] = String(planet)
end

function get_paths()
    paths = []
    for planet in keys(orbits)
        i = planet
        path = [i]
        while haskey(orbits, i)
            i = orbits[i]
            push!(path, i)
        end
        if "SAN" in path || "YOU" in path
            push!(paths, path)
        end
    end
    return paths
end

function find_orbital_transfer(paths)
    path_one = pop!(paths)
    path_two = pop!(paths)
    transfers = -2 # offset planet jumping
    meet_at = nothing # common root

    # find common root and distance from planet a
    for planet in path_one
        if planet in path_two
            meet_at = planet
            break
        end
        transfers += 1
    end

    # find distance from planet b
    for planet in path_two
        if planet == meet_at
            break
        end
        transfers += 1
    end

    return transfers
end

println(
    find_orbital_transfer(
        get_paths()
    )
)
