df <- tibble::tribble(
        ~respondent_id, ~question_number,            ~comment,                                                                   ~tags, ~sentiment,
           12299210937,        "q1_open",    "Test comment 1",                                    "Online Learning, Improved Teaching",  "Neutral",
           12299210937,        "q2_open",    "Test comment 2",                                       "FAC Authority, Personal Impacts", "Negative",
           12299210937,        "q3_open",    "Test comment 3",                                       "Biased Survey, Personal Impacts", "Negative",
           12293027241,        "q1_open",   "Other comment 1",                                "High Faculty Effort, Work-Life Balance",  "Neutral",
           12293027241,        "q2_open",   "Other comment 2",                                                   "High Faculty Effort", "Negative",
           12293027241,        "q3_open",   "Other comment 3",    "Teaching Eval Alternative, Low Student Effort, High Faculty Effort", "Negative",
           12290417487,        "q1_open", "Another comment 1",                                    "Online Learning, Improved Teaching", "Positive",
           12290417487,        "q2_open", "Another comment 2", "Connections with Students, Personal Impacts, Professional Development", "Negative",
           12290417487,        "q3_open", "Another comment 3",                                 "Department Support, Institute Support", "Positive",
           12286774660,        "q1_open",           "skipped",                                                                      NA,         NA,
           12286774660,        "q2_open",           "skipped",                                                                      NA,         NA,
           12286774660,        "q3_open",           "skipped",                                                                      NA,         NA,
           12285154862,        "q1_open",           "skipped",                                                                      NA,         NA,
           12285154862,        "q2_open",           "skipped",                                                                      NA,         NA,
           12285154862,        "q3_open",         "Comment 3",                                                        "Dependent Care", "Negative",
           12283796688,        "q1_open",            "Text 1",                                                         "Collaboration", "Positive",
           12283796688,        "q2_open",           "skipped",                                                                      NA,         NA,
           12283796688,        "q3_open",           "skipped",                                                                      NA,         NA
        )

library(tidyverse)

df %>%
  separate_rows(tags,
                sep = ", ") %>%
  count(tags)




# Jordan's Code -----------------------------------------------------------

# Function that splits a column by a particular delimiter

split_by_delimiter <- function(column, pattern, into_prefix) {

  cols <- str_split_fixed(column, pattern, n = Inf)

  cols[which(cols == "")] <- NA

  cols <- as_tibble(cols)

  # name the 'cols' tibble as 'into_prefix_1', 'into_prefix_2', ..., 'into_prefix_m'

  # where m = # columns of 'cols'

  m <- dim(cols)[2]

  names(cols) <- paste(into_prefix, 1:m, sep = "_")

}



# Applying function to data

delimited_data <- clean_data %>%

  select(respondent_id, tags) %>%

  bind_cols(split_by_delimiter(.$tags, pattern = ", ", into_prefix = "tag"))%>%

  select(respondent_id, starts_with("tag_"))
