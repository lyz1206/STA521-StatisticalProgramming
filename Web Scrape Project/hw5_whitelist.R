allowed_files = c("hw5.Rmd",
                  "README.md",
                  "wercker.yml",
                  "hw5.Rproj",
                  "hw5_whitelist.R",
                  "Makefile",
                  "get_lq.R",
                  "parse_lq.R",
                  "get_dennys.R",
                  "parse_dennys.R",
                  "hedberg.jpg")

files = dir()
disallowed_files = files[!(files %in% allowed_files)]

if (length(disallowed_files != 0))
{
  cat("Disallowed files found:\n")
  cat("  (remove the following files from your repo)\n\n")

  for(file in disallowed_files)
    cat("*",file,"\n")

  quit("no",1,FALSE)
}
