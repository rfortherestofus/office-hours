library(forestplot)
library(grid)


tabletext <- cbind(
  c("", "Study", "Auckland", "Block",
    "Doran", "Gamsu", "Morrison", "Papageorgiou",
    "Tauesch", NA, "Summary"),
  c("Deaths", "(steroid)", "36", "1",
    "4", "14", "3", "1",
    "8", NA, NA),
  c("Deaths", "(placebo)", "60", "5",
    "11", "20", "7", "7",
    "10", NA, NA),
  c("", "OR", "0.58", "0.16",
    "0.25", "0.70", "0.35", "0.14",
    "1.02", NA, "0.53"))


grid.newpage()
borderWidth <- unit(4, "pt")
width <- unit(convertX(unit(1, "npc") - borderWidth, unitTo = "npc", valueOnly = TRUE)/2, "npc")
pushViewport(viewport(layout = grid.layout(nrow = 1,
                                           ncol = 3,
                                           widths = unit.c(width,
                                                           borderWidth,
                                                           width))
)
)
pushViewport(viewport(layout.pos.row = 1,
                      layout.pos.col = 1))
forestplot(tabletext,
           title = "Original (1x)",
           rbind(HRQoL$Sweden),
           clip = c(-.1, Inf),
           col = clrs,
           xlab = "EQ-5D index",
           new_page = FALSE)
upViewport()
pushViewport(viewport(layout.pos.row = 1,
                      layout.pos.col = 2))
grid.rect(gp = gpar(fill = "#dddddd", col = "#eeeeee"))
upViewport()
pushViewport(viewport(layout.pos.row = 1,
                      layout.pos.col = 3))
forestplot(tabletext,
           title = "0.5x",
           fn.ci_norm = function(size, ...) {
             fpDrawNormalCI(size = size * 0.5, ...)
           },
           rbind(HRQoL$Sweden),
           clip = c(-.1, Inf),
           col = clrs,
           xlab = "EQ-5D index",
           new_page = FALSE)
upViewport(2)
