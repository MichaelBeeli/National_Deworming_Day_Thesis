## National Deworming Day Replication Package
## Author: Michael Beeli 
## Section: Exploratory Data Analysis
## Function: Stratified Scatterplot oF Test Score Achievement by Gender and Age Group

packages <- c(
  "tidyverse",
  "haven",
  "labelled",
  "forcats",
  "scales",
  "sjlabelled"
)

##############################################################################

# Change to install = TRUE to install the required packages
pacman::p_load(packages, character.only = TRUE, install = TRUE)

data <- read_dta("~/Documents/Thesis/Data/Clean_Data/Household/het_descriptives_bin.dta")




var_list <- c("bin_read_code", "bin_english_code", "bin_math_code")


reshaped <- data  %>%
  pivot_longer(all_of(var_list), names_to = "key", values_to = "value")

reshaped$Key <- str_c(reshaped$Gender, reshaped$key)

key_label <- names(reshaped$Key)

reshaped <- reshaped %>%
  arrange(num)

reshaped$Age = fct_relevel(as.factor(reshaped$Age), "5-7", "8-10", "11-13", "14-16")

reshaped$Key[reshaped$Key == "Femalebin_read_code"] = "Female: Reading"
reshaped$Key[reshaped$Key == "Femalebin_math_code"] = "Female: Math"
reshaped$Key[reshaped$Key == "Femalebin_english_code"] = "Female: English"

reshaped$Key[reshaped$Key == "Malebin_read_code"] = "Male: Reading"
reshaped$Key[reshaped$Key == "Malebin_math_code"] = "Male: Math"
reshaped$Key[reshaped$Key == "Malebin_english_code"] = "Male: English"

key_val <- as.vector(reshaped$Key)

p <- ggplot(reshaped, aes(x = Age, y = value, fill = Key )) + 
  geom_dotplot(
    binaxis = "y", position = "dodge",
    stackdir = "center", dotsize = 0.5, binwidth = 1/30
  ) +
  coord_flip(ylim = c(0, 1)) +
  scale_fill_discrete(breaks = key_val, labels = key_val) +
  scale_y_continuous() +
  xlab("Age") +
  ylab("Percent") +
  theme_classic() +
  theme(
    axis.text = element_text(size = 14),
    axis.line = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position=c(0.85, .26), 
    legend.box.background = element_rect(colour = "black"), 
    legend.title = element_text(size=12), 
    legend.text = element_text(size=10)
    
  ) 

p

dots_xaxis <- (ggplot_build(p)$data[[1]]["xmin"] + ggplot_build(p)$data[[1]]["xmax"]) / 2


# Adding geom_vline (vertical line) to the p ggplot ojbect
p + geom_vline(xintercept = as.numeric(dots_xaxis[,1]), size = 0.1, alpha = 0.8, lty = 2)

