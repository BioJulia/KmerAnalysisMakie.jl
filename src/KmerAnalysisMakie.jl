module KmerAnalysisMakie

export
    spectracn

using Observables
using AbstractPlotting

import KmerAnalysis: KmerFrequencySpectra, _find_plottable_subset


"""
    _find_plottable_subset(spec::KmerFrequencySpectra{1})

Utility method that automatically finds the highest k-mer frequency in a spectra
with a non-zero count, and returns a view of the spectra data that only goes up
to that detected frequeny.

Currently this is useful to have Makie primitives like `scatter` and `barplot`
not plot a large portion of the graph where there's basically nothing interesting.
"""
function _find_plottable_subset(spec::KmerFrequencySpectra{1})
    return view(spec.data, firstindex(spec.data):findprev(x -> x > 0, spec.data, lastindex(spec.data)))
end

"""
    _find_plottable_subset(spec::KmerFrequencySpectra{2})

Utility method that automatically finds the highest k-mer frequency in both of
a 2D spectras dimensions with a non-zero count, and returns a sub-view of the
spectra data that only goes up to those detected frequencies.

Currently this is useful to have Makie primitives like `heatmap` and `contour`
not plot a large portion of the graph where there's basically nothing interesting.
"""
function _find_plottable_subset(spec::KmerFrequencySpectra{2})
    mat = spec.data
    furthest_row = 0
    furthest_col = 0
    for col in 1:257
        for row in 1:257
            v = mat[row, col]
            furthest_row = ifelse((row > furthest_row) & !iszero(v), row, furthest_row)
            furthest_col = ifelse((col > furthest_col) & !iszero(v), col, furthest_col)
        end
    end
    return view(mat, 1:furthest_row, 1:furthest_col)
end

include(joinpath("type_recipes", "kmer_spectra.jl"))
include(joinpath("full_recipes", "spectracn.jl"))

end # module
