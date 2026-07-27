# A placeholder standing in for your real scripts.
#
# In the workshop we never run this -- the point is what happens to a file once
# it is under version control, not what the file does. Swap it for your own code
# when you set up your own repository.
#
# Base R only, so it has no dependencies to install.

coverage <- read.csv("data/raw/example_data.csv")

cat("Rows:", nrow(coverage), "\n")
cat("Samples:", length(unique(coverage$sample_id)), "\n")
cat("Regions:", paste(unique(coverage$region), collapse = ", "), "\n")

summary(coverage$mapped_reads)
