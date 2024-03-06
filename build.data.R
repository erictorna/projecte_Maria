library(data.table)
library(tidyverse)
library(readxl)
dades = read_xlsx('/home/idiap/data/dades_maria/BBDD_output_ICS.xlsx')
setDT(dades)

dades$Obesitat_dona = dades$Obesitat_don
dades$Obesitat_don<-NULL
global = dades %>% select('ABS_complet', 'ABSnom', 'ISC',  ends_with('_glob'))
homes = dades %>% select('ABS_complet', 'ABSnom', 'ISC', ends_with('_home'))
dones = dades %>% select('ABS_complet', 'ABSnom', 'ISC', ends_with('_dona'))

quantiles <- quantile(global$ISC, probs = seq(0, 1, by = 0.25))

global$ISC_Quartile <- cut(global$ISC, breaks = quantiles, labels = FALSE)

quantiles <- quantile(homes$ISC, probs = seq(0, 1, by = 0.25))

homes$ISC_Quartile <- cut(homes$ISC, breaks = quantiles, labels = FALSE)

quantiles <- quantile(dones$ISC, probs = seq(0, 1, by = 0.25))

dones$ISC_Quartile <- cut(dones$ISC, breaks = quantiles, labels = FALSE)


save(global, file= '/home/idiap/projects/dades_maria/global.RData')
save(homes, file= '/home/idiap/projects/dades_maria/homes.RData')
save(dones, file= '/home/idiap/projects/dades_maria/dones.RData')