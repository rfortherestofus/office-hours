
as_tibble(c("Q1", "Q2", "Q3", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "QE1", "QE2", "QE3", "QE4", "QE5", "QE6", "QE7", "QE8", "QE9", "QE10")) %>%
  set_names("question") %>%
  arrange(question) %>%
  # Extract just the numeric portion
  mutate(number = parse_number(question)) %>%
  mutate(number_padded = case_when(
    # If the number is two digits, leave it
    str_length(number) == 2 ~ as.character(number),
    # If the number is one digit, add a 0 on the left side
    str_length(number) == 1 ~ str_pad(number, side = "left", width = 2, pad = "0")
  )) %>%
  # Recreate the question variable
  mutate(question = str_glue("Q{number_padded}"))

