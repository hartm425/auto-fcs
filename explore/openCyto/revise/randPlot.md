ggcyto(gs1,
              mapping = aes(x = "FSC-W", y = "FSC-H"),
              subset = "SingletsTmp") +
    geom_hex(bins = 100) + ggcyto_par_set(limits = "data") + geom_gate()