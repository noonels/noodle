import Random

Iterations::Int = 5000
η::Float64 = 0.0005

ŷ(ω, e) = sum([ω[i] * e.x[i] for i in 1:length(e.x)])
sum_of_squares(E, ω) = sum([(e.y - ŷ(ω, e))^2 for e ∈ E])

struct example
    x::Array{Float64}
    y::Float64
end

function learn(ω::Array{Float64}, E, η)
    for _ ∈ 1:Iterations # Iterate prescribed number of times
        for e ∈ E
            ŷ_0 = ŷ(ω, e)
            δ::Float64 = e.y - ŷ_0
            for j in 1:length(e.x)
                ω[j] += η * δ * e.x[j]
            end
        end
    end
    return ω
end

function read_examples(input_file)
    E = []
    open(input_file) do f
        for line in eachline(f)
            ns = map(x -> parse(Float64, x), split(line))
            y = last(ns)
            xs = ns[1:length(ns)-1]
            push!(E, example(xs, y))
        end
    end
    return E
end

function main()
    if length(ARGS) > 0
        seed = parse(Int, ARGS[1])
    else
        seed = rand(1:1000000)
    end
    Random.seed!(seed)

    E = read_examples("trashdata.txt")
    Ev = read_examples("moretrashdata.txt")
    ω_0 = [rand(1.0:100.0), rand(1.0:100.0)]  # Random initial weights
    ω = learn(ω_0, E, η)

    println("""
    TRAINING
    Using random seed = $seed
    Using learning rate eta = $η
    After $Iterations iterations:
    Weights:
    ω1 = $(ω[1])
    ω2 = $(ω[2])

    VALIDATION
    Sum-of-Squares Error = $(sum_of_squares(Ev, ω))
    """)
end

main()
