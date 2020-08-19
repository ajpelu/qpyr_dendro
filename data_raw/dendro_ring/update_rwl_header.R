

# Update header files 
library(dplR)

sj <- read.rwl(fname=here::here("/data_raw/dendro_ring/sn_sanjuan/sn_sanjuan.rwl"), format="tucson")
h  <- list(site.id = "SJ",
                  site.name = "Robledal de San Juan, Sierra Nevada",
                  spp.code = "QPYR", state.country = "SPAIN",
                  spp = "QUERCUS PYRENAICA", elev = 1474, lat = 37.13,
                  long = -3.37, first.yr = 1921, last.yr = 2016,
                  lead.invs = "AJ PÉREZ-LUQUE", comp.date = "")

write.rwl(rwl.df = sj, fname = here::here("/data_raw/dendro_ring/sn_sanjuan/sn_SJ.rwl"),
                   format = "tucson", header = h,
                   append = FALSE, prec = 0.001)


ca <- read.rwl(fname=here::here("/data_raw/dendro_ring/sn_canar/sn_canar.rwl"), format="tucson")
h  <- list(site.id = "CA",
           site.name = "Robledal Cañar, Sierra Nevada",
           spp.code = "QPYR", state.country = "SPAIN",
           spp = "QUERCUS PYRENAICA", elev = 1800, lat = 36.97,
           long = -3.42, first.yr = 1819, last.yr = 2016,
           lead.invs = "AJ PÉREZ-LUQUE", comp.date = "")

write.rwl(rwl.df = ca, fname = here::here("/data_raw/dendro_ring/sn_canar/sn_CA.rwl"),
          format = "tucson", header = h,
          append = FALSE, prec = 0.001)

