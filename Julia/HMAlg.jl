module HMAlg

using Symbolics

export HM, genStaticHM, symbolicarray_fromsymbol, list_fromsymbol, view_fromsymbol, compose

struct HM
    Hx::Symbolics.Arr
    function HM(ind_seq, symbol::Symbol)
        new((@variables $symbol[ind_seq...])[1])
    end
end

HM(sz::Int...; symbol::Symbol) = HM(map(x -> 1:x, sz), symbol)

HM(sz::AbstractRange{Int}...; symbol::Symbol) = HM(sz, symbol)

eltypes(::Type{Symbolics.Arr{T,D}}) where {T,D} = (T, D)
eltypes(x::Symbolics.Arr) = eltypes(typeof(x))

Base.similar(A::AbstractArray, T::Type, dims::Tuple{AbstractRange{I}, Vararg{AbstractRange{I}}}) where {I<:Int} = similar(A, T, tuple(map(x -> length(x), dims)...))
    
Base.similar(f::Union{Function,DataType}, dims::Tuple{AbstractRange{I}, Vararg{AbstractRange{I}}}) where {I<:Int} = similar(f, tuple(map(x -> length(x), dims)...))

function genStaticHM(Hx::Symbolics.Arr{T,2}) where {T}
    println("2 method called! ", Hx)
    if any(firstindex.([Hx],[1:2...]') .!= 1)
        r,c = size(Hx)
        [Hx[i+r*j] for i in 1:r, j in 0:(c-1)]
    else
        [x for x in Hx]
    end
end

function genStaticHM(Hx::Symbolics.Arr{T,D}, dim1=0, dim2=1, dpths=nothing) where {T,D}
    println("general method called! ", Hx)
    if any(firstindex.([Hx],[1:D...]') .!= 1)
        [Hx[i] for i in CartesianIndex(repeat([1],D)...):CartesianIndex(size(Hx)...)]
    else
        [x for x in Hx]
    end
end

symbolicarray_fromsymbol(f) = arguments(Symbolics.value(f))[1]

list_fromsymbol(f)::Vector = arguments(Symbolics.value(f))[2:end]

view_fromsymbol(f) = @view arguments(Symbolics.value(f))[2:end]




import Base.∘

compose(fi::T...) where {T} = reduce(∘, fi) # This is where the type system breaks...

indexable_function(fi)::Function = x -> fi[x]

eager_compose(f1, f2) = map(indexable_function(f1),f2)

function lazy_compose(fi::Vector...)::Vector
    fcomposed = mapreduce(indexable_function, ∘, fi)
    [fcomposed(i) for i in 1:length(fi[1])]
end

compose(f1::Vector, f2::Vector)::Vector = eager_compose(f1, f2)

∘(f1::Vector, f2::Vector)::Vector = compose(f1, f2)

(compose(f1::Tuple{Vararg{T}}, f2::Tuple{Vararg{T}})::Tuple{Vararg{T}}) where {T} = eager_compose(f1, f2)

(∘(f1::Tuple{Vararg{T}}, f2::Tuple{Vararg{T}})::Tuple{Vararg{T}}) where {T} = compose(f1, f2)


eager_compose(fi::Num...)::Num = symbolicarray_fromsymbol(fi[1])[compose((fi .|> list_fromsymbol)...)...]

function lazy_compose(fi::Num...)::Num
    fcomposed = mapreduce(indexable_function ∘ list_fromsymbol, ∘, fi)
    symbolicarray_fromsymbol(fi[1])[(fcomposed(i) for i in 1:length(list_fromsymbol(fi[1])))...]
end

compose(fi::Num...)::Num = eager_compose(fi...)

end