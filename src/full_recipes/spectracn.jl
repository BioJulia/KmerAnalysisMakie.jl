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

function AbstractPlotting.plot!(plot::SpectraCN)
    # Lower to multiple barplots/plots here.
    spct = to_value(plot[:spectra])
    heights = cumsum(_find_plottable_subset(spct); dims = 2)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,7])], color = :orange)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,6])], color = :yellow)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,5])], color = :blue)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,4])], color = :green)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,3])], color = :purple)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,2])], color = :red)
    barplot!(plot, [Point2f0(i - 1, j) for (i, j) in enumerate(heights[:,1])], color = :black)
    # TODO: Figure out how to add a colour legend and perhaps axis labels.
    #xlabel!(plot, "K-mer multiplicity")
    #ylabel!(plot, "Number of distinct k-mers")
    #plot.parent[Axis].attributes[:names][:axisnames] = ("KmerMultiplicity", "Number of distinct k-mers")
    return plot
end
