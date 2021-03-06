simulate:
    exec: rt.R, rcauchy.R
    seed: R(1:5)
    params:
        n: 1000
        true_loc: 0, 1
    return: x, true_loc

transform:
    exec: winsor1.R, winsor2.R
    params:
        x: $x
        exec[1]:
            fraction: 0.05
        exec[2]:
            multiple: 3
    return: x

estimate:
    exec: mean.R, median.R
    params:
        x: $x
    return: loc

mse:
    exec: MSE.R
    params:
        mean_est: $loc
        true_mean: $true_loc
    return: mse

DSC:
    run: simulate *
         (transform * estimate, estimate) *
         mse
    exec_path: R
    output: dsc_result