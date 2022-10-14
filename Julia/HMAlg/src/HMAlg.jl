module HMAlg

using Symbolics

export HM, printHM

function HM(sz::Int...; symbol::Symbol)
    (@variables $symbol[map(x -> 1:x, sz)...])[1]
end

function HM(sz::AbstractRange{Int}...; symbol::Symbol)
    (@variables $symbol[sz...])[1]
end

eltypes(::Type{Symbolics.Arr{T,D}}) where {T,D} = (T, D)
eltypes(x::Symbolics.Arr) = eltypes(typeof(x))

Base.similar(A::AbstractArray, T::Type, dims::Tuple{AbstractRange{I}, Vararg{AbstractRange{I}}}) where {I<:Int} = similar(A, T, tuple(map(x -> length(x), dims)...))
    
Base.similar(f::Union{Function,DataType}, dims::Tuple{AbstractRange{I}, Vararg{AbstractRange{I}}}) where {I<:Int} = similar(f, tuple(map(x -> length(x), dims)...))

function printHM(Hx::Symbolics.Arr{T,2}) where {T}
    println("2 method called! ", Hx)
    if any(firstindex.([Hx],[1:2...]') .!= 1)
        r,c = size(Hx)
        [Hx[i+r*j] for i in 1:r, j in 0:(c-1)]
    else
        [x for x in Hx]
    end
end

function printHM(Hx::Symbolics.Arr{T,D}, dim1=0, dim2=1, dpths=nothing) where {T,D}
    println("general method called! ", Hx)
    if any(firstindex.([Hx],[1:D...]') .!= 1)
        [Hx[i] for i in CartesianIndex(repeat([1],D)...):CartesianIndex(size(Hx)...)]
    else
        [x for x in Hx]
    end
end



end