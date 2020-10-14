## Birmingham R User Group Meeting
## October 14, 2020
## Very easy intro to LM

# Load libraries:

library(tidyverse)
library(broom)

# Generate some random data with intercept = 2 and slope = 3:

x <- rnorm(50)
y <- 2 + 3 * x + rnorm(50)

# Put into tibble:

d <- tibble(x, y)

# Make a plot out of this:

d %>% ggplot(aes(x = x, y = y)) +
  geom_point() +
  theme_minimal()

# Create a linear model:

xmdl <- lm(y ~ x, data = d)

# Fitted versus residual values:

fitted(xmdl)
residuals(xmdl)

# The base R summary output is untidy and hard to manipulate:

summary(xmdl)

# Model summary in tidy with broom:

glance(xmdl)

# Coefficient table in tidy with broom:

tidy(xmdl)

# Extract coefficients:

coefs <- tidy(xmdl) %>% pull(estimate)
int <- coefs[1]
slope <- coefs[2]

# Calculate predictions, let's say for x = 2:

int + slope * 2
int + slope * seq(-2, 2, 0.1)

# The predict function does wonders:

predict(xmdl,
        newdata = tibble(x = seq(-2, 2, 0.1)))

# Make a plot with model:

d %>% ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_minimal()

