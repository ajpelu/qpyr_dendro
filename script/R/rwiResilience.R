## Compute Resilience of RWI

## Resilience metrics: See Lloret et al. 2011 http://dx.doi.org/10.1111/j.1600-0706.2011.19372.x
## rwi_tree: an object of rwi by tree
## event_years: vector with drought years, i.e.: c(1995, 2005)
## window: size of the window to compute previous and post event segments

## A list with  to df
## $rwi: summary statistics by tree of RWI for each period (prev, dr, post)
## $resilience: resilience metrics for each drougth period

rwiResilience <- function(rwi_tree, event_years, window) {
  out_rwi <- c()
  out_res <- c()
  out <- list()

  require(dplyr)

  for (i in event_years) {
    # Create df previous, during and post event
    df <- rwi_tree %>%
      mutate(year = as.numeric(row.names(.))) %>%
      as.data.frame()

    df_pre <- df %>% filter(year < i & year >= (i - window)) %>% mutate(disturb = "pre")
    df_event <- df %>% filter(year == i) %>% mutate(disturb = "dr")
    df_post <- df %>% filter(year > i & year <= (i + window)) %>% mutate(disturb = "post")

    # Melt data
    dfmelt <- bind_rows(df_pre, df_event, df_post) %>%
      gather(tree, value, -disturb, -year)

    # Compute mean of RWI (previous, during and posterior)
    rwi_df <- dfmelt %>%
      group_by(disturb, tree) %>%
      summarise(
        mean_period = mean(value),
        sd_period = sd(value),
        se_period = sd_period / sqrt(length(value))
      ) %>%
      mutate(disturb_year = i) %>%
      as.data.frame()

    out_rwi <- rbind(out_rwi, rwi_df)


    # Compute resilience by trees
    aux_resilience <- c()
    trees <- unique(rwi_df$tree)

    for (t in trees) {
      # Filter by tree
      df_tree <- rwi_df %>% filter(tree == t)

      # Compute resilience metrics by tree
      aux_df <- df_tree %>%
        dplyr::select(-c(tree, sd_period, se_period)) %>%
        spread(key = disturb, value = mean_period) %>%
        mutate(
          rt = dr / pre,
          rc = post / dr,
          rs = post / pre,
          rrs = ((post - dr) / pre),
          tree = t
        ) %>%
        dplyr::select(rt, rc, rs, rrs, disturb_year, tree) %>%
        as.data.frame()

      aux_resilience <- rbind(aux_resilience, aux_df)
    }

    out_res <- rbind(out_res, aux_resilience)
  }

  out$rwi <- out_rwi
  out$resilience <- out_res

  return(out)
}
