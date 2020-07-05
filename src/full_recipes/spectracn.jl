"""
    spectracn(spectra; kwargs...)

Draw a spectra copy number plot for a 2D k-mer frequency spectra.
The spectracn plot consists of a set of differently coloured, stacked barplots.

# Arguments
- `spectra`: A 2D Kmer frequency spectra (`KmerFrequencySpectra{2}`)
"""
@recipe(SpectraCN, spectra) do scene
    default_theme(scene, BarPlot)
end

const CN_COLOUR = [:black, :red, :purple, :green, :blue, :yellow, :orange]

function AbstractPlotting.plot!(plot::SpectraCN)
    # Lower to multiple barplots/plots here.
    spct = to_value(plot[:spectra])
    heights = cumsum(_find_plottable_subset(spct); dims = 2)
    @inbounds for col in size(heights)[2]:-1:1
        barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,col])], color = CN_COLOUR[col])
    end
    # TODO: Figure out how to add a colour legend and perhaps axis labels.
    #xlabel!(plot, "K-mer multiplicity")
    #ylabel!(plot, "Number of distinct k-mers")
    #plot.parent[Axis].attributes[:names][:axisnames] = ("KmerMultiplicity", "Number of distinct k-mers")
    return plot
end
