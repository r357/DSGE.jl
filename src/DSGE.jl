isdefined(Base, :__precompile__) && __precompile__()

module DSGE
    using Compat, Distributions, Roots.fzero, HDF5, Debug
    using DataStructures: SortedDict, insert!, ForwardOrdering
    
    if VERSION < v"0.4-"
        using Docile
    end

    export

        # distributions_ext.jl
        BetaAlt, GammaAlt,

        # settings.jl
        Setting, get_setting, default_settings, default_test_settings,

        # abstractdsgemodel.jl
        AbstractDSGEModel, tomodel!, toreal!, num_states, num_shocks_exogenous,
        num_shocks_expectational, spec, subspec, 
        modelpath, inpath, workpath, rawpath, tablespath, figurespath, logpath,
        reoptimize, recalculate_hessian, num_mh_blocks, num_mh_simulations,
        num_mh_burn, mh_thinning_step, data_vintage,

        
        # parameters.jl
        parameter, Transform, Untransformed, SquareRoot, Exponential, NullablePrior,
        AbstractParameter, Parameter, ParameterVector, ScaledParameter, UnscaledParameter,
        SteadyStateParameter, toreal, tomodel, update, update!, tomodel, toreal, Interval,
        ParamBoundsError,
        
        # estimate/
        dlyap, kalman_filter, likelihood, posterior, posterior!,
        optimize!, csminwel, hessian!, estimate, proposal_distribution,
        metropolis_hastings, compute_parameter_covariance, compute_moments,
        make_moment_tables, find_density_bands, prior,
        
        # models/
        steadystate!, Model990, Model994, SmetsWouters, eqcond, measurement,

        # solve/
        ordschur, gensys, solve
    
    const VERBOSITY = @compat(Dict{Symbol,Int}(:none => 0, :low => 1, :high => 2))

    include("parameters.jl")
    include("distributions_ext.jl")
    include("abstractdsgemodel.jl")
    include("settings.jl")
    
    if VERSION <= v"0.4-"
        include("solve/ordered_qz.jl")
    end
    
    
    include("models/m990/m990.jl")
    include("models/m990/subspecs.jl")
    include("models/m990/eqcond.jl")
    include("models/m990/measurement.jl")

    include("models/m994/m994.jl")
    include("models/m994/subspecs.jl")
    include("models/m994/eqcond.jl")
    include("models/m994/measurement.jl")

    include("models/smets_wouters/smets_wouters.jl")
    include("models/smets_wouters/subspecs.jl")
    include("models/smets_wouters/eqcond.jl")
    include("models/smets_wouters/measurement.jl")
    include("models/smets_wouters/augment_states.jl")

    include("solve/gensys.jl")
    include("solve/solve.jl")
    
    include("estimate/kalman.jl")
    include("estimate/dlyap.jl")
    include("estimate/posterior.jl")
    include("estimate/csminwel.jl")
    include("estimate/hessian.jl")
    include("estimate/estimate.jl")
    include("estimate/moments.jl")

end
