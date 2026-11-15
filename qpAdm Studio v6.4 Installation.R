# qpAdm Studio v6.4 -- arayuz paketleri kurulumu / interface package installer (RUN ONCE)
# TR: Bu dosyayi RStudio'da acip 'Source' de.  |  EN: Open in RStudio and click 'Source'.
# RStudio'da: bu dosyayi ac, sag ustteki "Source" dugmesine bas
# (ya da asagidaki satirlari Console'a yapistir).
# NOT: Once Session > Restart R yapip bu dosyayi TEMIZ oturumda calistirmak en saglamidir.
# KOLAY YOL / EASY WAY (v6.4): "qpAdm Studio BASLAT.bat" (paylasim zip'inde) R'i, paketleri ve
#   admixtools'u kendisi kurar ve programi baslatir; bu betik RStudio ile calisanlar icindir.
# ONEMLI: Bu betik SADECE arayuz paketlerini kurar. R, RStudio, Rtools ve
#   admixtools2 kurulumu icin kurulum.txt dosyasindaki ADIM 1-4'e bak.

# rlang guncel degilse once onu guncelle (shinyFiles vb. >= 1.1.7 ister)
if (!requireNamespace("rlang", quietly = TRUE) || utils::packageVersion("rlang") < "1.1.7") {
  message("rlang guncelleniyor (>= 1.1.7 gerekli)...")
  install.packages("rlang")
  message("*** rlang guncellendi. Lutfen Session > Restart R yapip bu dosyayi TEKRAR calistir. ***")
}

# jsonlite: zorunlu degil (kodda requireNamespace ile korumali); kurulu degilse
#   f2 havuz yan dosyasi (qps_pool.json) dput bicimiyle yazilir.
# v5.8: plotly + htmlwidgets EKLENDI -- qpGraph > Duzenleyici alt sekmesi icin.
#   Yumusak bagimlilik: kurulu degilse program yine acilir, yalnizca o alt
#   sekmede kurulum mesaji gorunur.
# v5.9: yeni paket YOK.
# v6.0: yeni paket YOK.
# v6.1: yeni paket YOK.
# v6.2: yeni paket YOK.
# v6.3 test: yeni paket YOK.
# v6.3 test2: yeni paket YOK.
# v6.3: yeni paket YOK.
# v6.4 test, v6.4: yeni paket YOK.
pkgs <- c("shiny","bslib","DT","shinyFiles","openxlsx","digest",
          "callr","ggplot2","ggpubr","patchwork","scales","ragg","cowplot","jsonlite",
          "plotly","htmlwidgets")

eksik <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
if (length(eksik)) {
  message("Kuruluyor: ", paste(eksik, collapse = ", "))
  install.packages(eksik)
} else {
  message("Tum arayuz paketleri zaten kurulu.")
}

if (!requireNamespace("admixtools", quietly = TRUE)) {
  message("\n*** DIKKAT: admixtools kurulu DEGIL. ***")
  message("Once admixtools2'yi kurmalisin (Rtools gerekebilir):")
  message('  install.packages("remotes"); remotes::install_github("uqrmaie1/admixtools")')
} else {
  message("\nadmixtools: TAMAM.")
  message("Simdi programi calistirabilirsin:")
  message('  Session > Set Working Directory > Choose Directory  (program klasoru)')
  message('  app <- source("qpAdm Studio v6.4.R", encoding = "UTF-8")$value')
  message('  shiny::runApp(app)   # tarayicida; port 7654, doluysa 7655-7699')
  message('  ASLA: runApp("dosya_yolu.R")')
}
