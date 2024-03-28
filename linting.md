`library(lintr)`

For a single file you want to lint, try something like
```
ll <- linters_with_defaults(commented_code_linter = NULL,
                            quotes_linter = NULL,  # annoying to suggest double quotes
                            object_usage_linter = NULL,
                            indentation_linter(indent = 4))

lint(filename, linters = ll)
```
