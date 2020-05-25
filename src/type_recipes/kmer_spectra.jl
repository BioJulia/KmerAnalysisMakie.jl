
function AbstractPlotting.convert_arguments(::AbstractPlotting.PointBased, spec::KmerFrequencySpectra{1})
    tv = _find_plottable_subset(spec)
    return ([Point2f0(i - 1, j) for (i, j) in enumerate(tv)],)
end

function AbstractPlotting.convert_arguments(p::AbstractPlotting.SurfaceLike, spec::KmerFrequencySpectra{2})
    return AbstractPlotting.convert_arguments(p, _find_plottable_subset(spec))
end

AbstractPlotting.plottype(::KmerFrequencySpectra{1}) = AbstractPlotting.BarPlot
AbstractPlotting.plottype(::KmerFrequencySpectra{2}) = AbstractPlotting.Heatmap