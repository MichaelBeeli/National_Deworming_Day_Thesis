## National Deworming Day Replication Package
## Author: Michael Beeli 
## Section: Exploratory Data Analysis
## Function: Descriptive Histograms by age and test type


packages <- c(
  "tidyverse",
  "haven",
  "labelled",
  "forcats",
  "scales",
  "sjlabelled",
  "ggpubr"
)

##############################################################################

# Change to install = TRUE to install the required packages
pacman::p_load(packages, character.only = TRUE, install = TRUE)

data <- read_dta("~/Documents/Thesis/Data/Clean_Data/Household/het_descriptives.dta")

#setwd("~/Documents/Github/Thesis/Replication Package/Figures")

data <- data %>%
  arrange(num, n)

data$Age = fct_relevel(as.factor(data$Age), "5-7", "8-10", "11-13", "14-16")

sixteen <- data[data$Age=="14-16",]
thirteen <- data[data$Age=="11-13",]
ten <- data[data$Age=="8-10",]
seven <- data[data$Age=="5-7",]

sixteenm <- sixteen[sixteen$type=="math",]
sixteenr <- sixteen[sixteen$type=="read",]
sixteene <- sixteen[sixteen$type=="english",]

thirteenm <- thirteen[thirteen$type=="math",]
thirteenr <- thirteen[thirteen$type=="read",]
thirteene <- thirteen[thirteen$type=="english",]

tenm <- ten[ten$type=="math",]
tenr <- ten[ten$type=="read",]
tene <- ten[ten$type=="english",]

sevenm <- seven[seven$type=="math",]
sevenr <- seven[seven$type=="read",]
sevene <- seven[seven$type=="english",]


m7 <- ggplot(sevenm, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "palegreen4"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)


r7 <- ggplot(sevenr, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "palegreen4"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)
  


e7 <- ggplot(sevene, aes(y= code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "palegreen4"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)


m10 <- ggplot(tenm, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "red"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

r10 <- ggplot(tenr, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "red"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)



e10 <- ggplot(tene, aes(y= code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "red"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

m13 <- ggplot(thirteenm, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "dodgerblue3"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

r13 <- ggplot(thirteenr, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "dodgerblue3"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

e13 <- ggplot(thirteene, aes(y= code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "dodgerblue3"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)


m16 <- ggplot(sixteenm, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "mediumorchid4"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

r16 <- ggplot(sixteenr, aes(y=code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "mediumorchid4"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

e16 <- ggplot(sixteene, aes(y= code, x=k, alpha=0.5)) +
  geom_bar(
    stat = "identity",
    fill = "mediumorchid4"
  ) +
  theme_classic() + 
  xlab("Score") +
  ylab("Density") +
  theme(
    legend.position = "none"
  ) +
  geom_text(aes(label=round(code, digits = 3)), vjust=1.6, color="black", size=4)

e16


theme_set(theme_pubr())

math_hist <- ggarrange(m7, m10, m13, m16, labels=c("5-7", "8-10", "11-13", "14-16"), hjust = c(-5.75, -1.5, -3, -3), legend="none")



ggsave("math_hist.png", device = png)

read <- ggarrange(r7, r10, r13, r16, labels=c("5-7", "8-10", "11-13", "14-16"), hjust = c(-5.75, -3.75, -3, -3), legend="none")


ggsave("read_hist.png", device = png)

english <- ggarrange(e7, e10, e13, e16, labels=c("5-7", "8-10", "11-13", "14-16"), hjust = c(-5.75, -2.9, -3, -3), legend="none")

ggsave("english_hist.png", device = png)









