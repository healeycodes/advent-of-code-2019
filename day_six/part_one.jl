filename = ARGS[1]
input = readlines(filename)
orbits = Dict()
for orbit in input
    planet, moon = split(orbit, ')')
    orbits[moon] = planet
end

function count_orbits()
    count = 0
    for planet in keys(orbits)
        i = planet
        while haskey(orbits, i)
            i = orbits[i]
            count += 1
        end
    end
    return count
end

println(
    count_orbits()
)