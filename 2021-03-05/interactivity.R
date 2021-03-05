library(tidyverse)
library(palmerpenguins)

data(penguins)


# Custom Theme ------------------------------------------------------------

library(hrbrthemes)

theme_dk <- function(axis_title_size = 0,
                     font_family = "iA Writer Mono S",
                     ...) {

  light_gray <- "#999999"

  theme_ipsum(base_family = font_family,
              axis_title_size = axis_title_size,
              ...) +
    theme(axis.text.x = element_text(color = light_gray),
          axis.text.y = element_text(color = light_gray),
          plot.title.position = "plot")

  }

theme_set(theme_dk(axis_title_size = 9))

penguins %>%
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point() +
  labs(title = "This is my incredible penguin plot",
       subtitle = "Aren't you just super impressed?")





# ggiraph -----------------------------------------------------------------

# https://davidgohel.github.io/ggiraph/index.html

library(ggiraph)

penguins %>%
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             tooltip = bill_depth_mm,
             label = bill_depth_mm)) +
  geom_point_interactive()




tooltip_css <-
  "background-color:#ffffff; color: #000000; padding: 5px; border-radius: 2px; border: 1px solid #333333; box-shadow: 0 8px 48px -8px rgba(64, 78, 107, 0.1); font-family: 'iA Writer Mono S';"

penguin_plot <- penguins %>%
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm,
             tooltip = bill_depth_mm)) +
  geom_point_interactive() +
  labs(title = "This is my incredible penguin plot!",
       subtitle = "Aren't you just super impressed?")

interactive_plot <- girafe(ggobj = penguin_plot,
       options = list(
         opts_tooltip(css = tooltip_css),
         opts_toolbar(saveaspng = FALSE)
       ))

interactive_plot

htmlwidgets::saveWidget(widget = interactive_plot,
                        file = "interactive-graph.html")

# plotly ------------------------------------------------------------------

library(plotly)

penguin_plot_2 <- penguins %>%
  ggplot(aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point() +
  labs(title = "This is my incredible penguin plot",
       subtitle = "Aren't you just super impressed?")

font <- list(
  family = "iA Writer Mono S",
  size = 15,
  color = "white"
)

label <- list(
  bgcolor = "#232F34",
  bordercolor = "transparent",
  font = font
)


penguin_plot_2 %>%
  ggplotly() %>%
  style(hoverlabel = label, marker.color = "#232F34") %>%
  layout(font = font)
