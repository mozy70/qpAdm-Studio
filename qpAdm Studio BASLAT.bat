@echo off
chcp 65001 >nul
setlocal EnableExtensions DisableDelayedExpansion
rem qpAdm Studio -- kurulum ve baslatici / installer and launcher (v6.4). Uretici: gelistirme_v64\bat_v64.py
rem Bu dosyayi program dosyasinin yanina koyup cift tiklayin. / Put this file next to the program file and double-click it.
rem Dil: Windows goruntuleme dili Turkce ise Turkce, degilse Ingilizce. / Language: Turkish if the Windows display language is Turkish, otherwise English.
cd /d "%~dp0"
set "QPS_DIR=%~dp0"
set "QPS_BAT=%~f0"
set "QPS_PROG=qpAdm Studio v6.4.R"
set "QPS_RVER=4.5.1"
set "QPS_PORT=7654"
set "QPS_BAT_LANG=en"
set "UIL="
for /f "usebackq delims=" %%L in (`powershell -NoProfile -NonInteractive -Command "[Globalization.CultureInfo]::CurrentUICulture.TwoLetterISOLanguageName" 2^>nul`) do set "UIL=%%L"
if /i "%UIL%"=="tr" set "QPS_BAT_LANG=tr"
if "%QPS_BAT_LANG%"=="tr" goto metin_tr
goto metin_en
:metin_tr
set "M_TITLE=qpAdm Studio — kurulum ve başlatıcı"
set "M_S1=[1/5] Program dosyası aranıyor..."
set "M_PROG_YOK=Program dosyası (qpAdm Studio v... .R) bu klasörde yok. Bu .bat dosyasını program dosyasının yanına koyun; zip içinden çalıştırıyorsanız önce zip'i sağ tıklayıp Tümünü ayıkla ile çıkarın."
set "M_S2=[2/5] R aranıyor..."
set "M_R_ESKI=Bulunan R 4.3'ten eski; R 4.5.1 kullanıcı klasörünüze ayrıca kurulacak (yönetici izni gerekmez)."
set "M_R_YOK=R bulunamadı; R 4.5.1 kullanıcı klasörünüze kurulacak (yönetici izni gerekmez)."
set "M_R_DL=R 4.5.1 indiriliyor (yaklaşık 90 MB; bağlantıya göre birkaç dakika sürebilir)..."
set "M_R_INST=R 4.5.1 kuruluyor (birkaç dakika sürebilir; kurulum penceresi kendiliğinden kapanır)..."
set "M_R_DL_HATA=R indirilemedi. İnternet bağlantısını denetleyin ya da R'ı https://cran.r-project.org adresinden kendiniz kurup bu dosyayı yeniden çalıştırın."
set "M_R_KUR_HATA=R kurulamadı. R'ı https://cran.r-project.org adresinden kendiniz kurup bu dosyayı yeniden çalıştırın."
set "M_S3=[3/5] Paketler denetleniyor (ilk çalıştırmada eksikler kurulur; uzun sürebilir)..."
set "M_DONE=Bitti."
set "M_FAIL=İşlem tamamlanamadı; yukarıdaki iletiye bakın."
set "M_PRESS=Kapatmak için bir tuşa basın."
goto metin_hazir
:metin_en
set "M_TITLE=qpAdm Studio — installer and launcher"
set "M_S1=[1/5] Looking for the program file..."
set "M_PROG_YOK=The program file (qpAdm Studio v... .R) is not in this folder. Put this .bat file next to the program file; if you are running it from inside a zip, first extract the zip with right-click, Extract All."
set "M_S2=[2/5] Looking for R..."
set "M_R_ESKI=The R found is older than 4.3; R 4.5.1 will also be installed in your user folder (no administrator rights needed)."
set "M_R_YOK=R not found; R 4.5.1 will be installed in your user folder (no administrator rights needed)."
set "M_R_DL=Downloading R 4.5.1 (about 90 MB; may take a few minutes depending on your connection)..."
set "M_R_INST=Installing R 4.5.1 (may take a few minutes; the setup window closes by itself)..."
set "M_R_DL_HATA=R could not be downloaded. Check the internet connection, or install R yourself from https://cran.r-project.org and run this file again."
set "M_R_KUR_HATA=R could not be installed. Install R yourself from https://cran.r-project.org and run this file again."
set "M_S3=[3/5] Checking packages (missing ones are installed on the first run; this can take long)..."
set "M_DONE=Done."
set "M_FAIL=Could not finish; see the message above."
set "M_PRESS=Press a key to close."
goto metin_hazir
:metin_hazir
title %M_TITLE%
echo(%M_TITLE%
echo(

echo(%M_S1%
if exist "%QPS_DIR%%QPS_PROG%" goto prog_var
set "QPS_PROG="
for /f "delims=" %%f in ('dir /b /o:n "%QPS_DIR%qpAdm Studio v*.R" 2^>nul ^| findstr /v /i /c:"Installation"') do set "QPS_PROG=%%f"
if not defined QPS_PROG goto prog_yok
:prog_var
echo(    %QPS_PROG%

echo(%M_S2%
set "RS="
for /f "delims=" %%i in ('where Rscript.exe 2^>nul') do if not defined RS set "RS=%%i"
if not defined RS call :kayit HKLM 64
if not defined RS call :kayit HKCU 64
if not defined RS call :kayit HKLM 32
if not defined RS call :kayit HKCU 32
if not defined RS call :klasor "%ProgramFiles%\R"
if not defined RS call :klasor "%LOCALAPPDATA%\Programs\R"
if not defined RS goto r_yok
"%RS%" -e "quit(status = if (getRversion() >= '4.3.0') 0 else 3)" >nul 2>&1
if errorlevel 3 goto r_eski
goto r_var

:r_eski
echo(    %RS%
echo(%M_R_ESKI%
goto r_kur
:r_yok
echo(%M_R_YOK%
:r_kur
set "RDIR=%LOCALAPPDATA%\Programs\R\R-%QPS_RVER%"
set "RS=%RDIR%\bin\Rscript.exe"
if exist "%RS%" goto r_var
set "RFILE=%TEMP%\R-%QPS_RVER%-win.exe"
echo(%M_R_DL%
call :indir "https://cloud.r-project.org/bin/windows/base/old/%QPS_RVER%/R-%QPS_RVER%-win.exe" "%RFILE%"
if errorlevel 1 call :indir "https://cran.r-project.org/bin/windows/base/old/%QPS_RVER%/R-%QPS_RVER%-win.exe" "%RFILE%"
if errorlevel 1 goto r_indirme_hata
echo(%M_R_INST%
start "" /wait "%RFILE%" /SILENT /SUPPRESSMSGBOXES /NORESTART /SP- /CURRENTUSER /NOICONS /DIR="%RDIR%"
del "%RFILE%" >nul 2>&1
if not exist "%RS%" goto r_kurulum_hata

:r_var
echo(    %RS%
echo(
echo(%M_S3%
"%RS%" -e "x<-readLines(Sys.getenv('QPS_BAT'),encoding='UTF-8',warn=FALSE);i<-grep('^#QPS_R_BASLA$',x);eval(parse(text=x[-seq_len(i[length(i)])],encoding='UTF-8'),envir=new.env())"
if errorlevel 1 goto hata
goto bitti

:prog_yok
echo(%M_PROG_YOK%
goto hata
:r_indirme_hata
echo(%M_R_DL_HATA%
goto hata
:r_kurulum_hata
echo(%M_R_KUR_HATA%
goto hata

:bitti
echo(
echo(%M_DONE%
timeout /t 5 >nul
exit /b 0

:hata
echo(
echo(%M_FAIL%
echo(%M_PRESS%
pause >nul
exit /b 1

:kayit
for /f "tokens=2,*" %%a in ('reg query "%~1\Software\R-core\R" /v InstallPath /reg:%~2 2^>nul ^| find "InstallPath"') do if exist "%%b\bin\Rscript.exe" set "RS=%%b\bin\Rscript.exe"
exit /b 0

:klasor
for /d %%d in ("%~1\R-*") do if exist "%%d\bin\Rscript.exe" set "RS=%%d\bin\Rscript.exe"
exit /b 0

:indir
set "QPS_URL=%~1"
set "QPS_OUT=%~2"
where curl.exe >nul 2>&1
if errorlevel 1 goto indir_ps
curl.exe -L --fail --retry 2 -# -o "%QPS_OUT%" "%QPS_URL%"
exit /b %errorlevel%
:indir_ps
powershell -NoProfile -NonInteractive -Command "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest -UseBasicParsing -Uri $env:QPS_URL -OutFile $env:QPS_OUT; exit 0 } catch { exit 1 }"
exit /b %errorlevel%
#QPS_R_BASLA
# ---- R parcasi: Rscript bu satirdan sonrasini calistirir (cmd buraya hic gelmez). Ortam: QPS_BAT_LANG, QPS_DIR, QPS_PROG,
# QPS_PORT (.bat koyar). QPS_BAT_SINAMA dolu ise yalniz tanimlar yuklenir (testler).
QPS_TR <- identical(Sys.getenv("QPS_BAT_LANG"), "tr")
QPS_PORT <- as.integer(Sys.getenv("QPS_PORT", "7654"))
QPS_PKGS <- c("shiny", "bslib", "DT", "shinyFiles", "openxlsx", "digest", "callr", "ggplot2", "ggpubr", "patchwork", "scales", "ragg", "cowplot", "jsonlite", "plotly", "htmlwidgets", "readr")
QPS_RLANG_MIN <- "1.1.7"
QPS_EXP <- c("edges_to_igraph", "extract_f2", "f2", "f2_from_precomp", "f4blockdat_to_f4blocks", "fst", "get_block_lengths", "is_valid", "packedancestrymap_to_afs", "parse_dot", "parse_qpgraph_graphfile", "plink_to_afs", "plot_graph", "qp3pop", "qpadm", "qpdstat", "qpf4diff", "qpf4ratio", "qpgraph", "rotate_models", "unidentifiable_edges")
QPS_INT <- c("afs_to_f2_blocks", "cpp_aftable_to_dstatnum", "cpp_is_polymorphic", "discard_from_aftable")
QPS_ADX_SHA <- "2f6957a36224c15884abf84c543aefddf46352f0"   # kullanicinin Windows'ta derledigi ve olcumlerin yapildigi commit
QPS_RUNIV <- "https://evolecolgroup.r-universe.dev"           # upstream GitHub'dan derleyen r-universe (yazarin kendi evreni yok)
QPS_RT <- if (getRversion() >= "4.5.0") "45" else paste0(R.version$major, sub("\\..*$", "", R.version$minor))   # Rtools45: R 4.5 ve sonrasi (4.6, 4.7 dahil); R 4.4 -> 44, 4.3 -> 43
QPS_RTOOLS <- sprintf("https://cran.r-project.org/bin/windows/Rtools/rtools%s/files/", QPS_RT)
qps_m <- function(tr, en, ...) { s <- if (QPS_TR) tr else en; if (...length()) s <- sprintf(s, ...); cat(s, "\n", sep = ""); flush.console() }
qps_dur <- function(tr, en, ...) { qps_m(tr, en, ...); quit(save = "no", status = 1) }
qps_var <- function(p) nzchar(system.file(package = p))
qps_lib <- function() { u <- path.expand(Sys.getenv("R_LIBS_USER")); if (nzchar(u)) { dir.create(u, recursive = TRUE, showWarnings = FALSE); .libPaths(c(u, .libPaths())) }; .libPaths()[1] }
qps_port_acik <- function(port = QPS_PORT) { s <- tryCatch(suppressWarnings(socketConnection("127.0.0.1", port = port, open = "r+", blocking = TRUE, timeout = 2)), error = function(e) NULL); if (is.null(s)) return(FALSE); close(s); TRUE }
# v6.4: portu dinleyen qpAdm Studio mu (sayfadaki <meta name="qps-app">); calisan kopyanin portu (qps_port.txt ya da QPS_PORT); ilk bos port
qps_is_qps <- function(port) { op <- options(timeout = 3); on.exit(options(op), add = TRUE)
  x <- tryCatch({ con <- url(sprintf("http://127.0.0.1:%d/", as.integer(port))); on.exit(try(close(con), silent = TRUE), add = TRUE); suppressWarnings(readLines(con, n = 400L, warn = FALSE)) }, error = function(e) character(0))
  any(grepl("name=\"qps-app\"", x, fixed = TRUE)) }
qps_calisan <- function(dir) { f <- file.path(dir, "qps_port.txt")
  p <- if (file.exists(f)) suppressWarnings(as.integer(strsplit(tryCatch(readLines(f, n = 1L, warn = FALSE), error = function(e) "")[1], "\t", fixed = TRUE)[[1]][1])) else NA_integer_
  for (q in unique(stats::na.omit(c(p, QPS_PORT)))) if (qps_port_acik(q) && qps_is_qps(q)) return(as.integer(q)); NA_integer_ }
qps_bos_port <- function() { for (q in unique(c(QPS_PORT, 7654:7699))) if (!qps_port_acik(q)) return(as.integer(q)); NA_integer_ }
qps_eksik_paket <- function() { e <- QPS_PKGS[!vapply(QPS_PKGS, qps_var, logical(1))]
  if (qps_var("rlang") && utils::packageVersion("rlang") < QPS_RLANG_MIN) e <- unique(c("rlang", e)); e }
qps_kur <- function(p, ...) { qps_m("    Kuruluyor (%d): %s", "    Installing (%d): %s", length(p), paste(p, collapse = ", "))
  utils::install.packages(p, lib = .libPaths()[1], dependencies = c("Depends", "Imports", "LinkingTo"), ...) }
# admixtools paketi YUKLENMEDEN denetlenir (NAMESPACE dosyasi + tembel yukleme veritabani): DLL kilitlenmez, gerekirse
# ayni oturumda yeniden kurulabilir. Doner: eksik islevlerin adlari (bos = tamam).
qps_adx_eksik <- function() { d <- system.file(package = "admixtools"); if (!nzchar(d)) return("admixtools")
  nsf <- tryCatch(readLines(file.path(d, "NAMESPACE"), warn = FALSE), error = function(e) character(0))
  ex <- gsub("[\"` ]", "", sub("^export\\((.*)\\)\\s*$", "\\1", grep("^export\\(", nsf, value = TRUE)))
  e <- new.env(); ok <- tryCatch({ lazyLoad(file.path(d, "R", "admixtools"), envir = e); TRUE }, error = function(err) FALSE)
  if (!ok) return("admixtools (R/admixtools.rdb)")
  c(setdiff(QPS_EXP, ex), QPS_INT[!vapply(QPS_INT, exists, logical(1), envir = e, inherits = FALSE)]) }
# Islev denetimi: paket yuklenir, ornek f2 bloklariyla bir qpadm calisir.
qps_adx_dene <- function() tryCatch({ suppressPackageStartupMessages(loadNamespace("admixtools")); e <- new.env()
  utils::data("example_f2_blocks", package = "admixtools", envir = e); f2 <- e$example_f2_blocks; p <- dimnames(f2)[[1]]
  r <- admixtools::qpadm(f2, left = p[c(1, 3)], right = p[c(2, 4, 5, 6)], target = p[7], verbose = FALSE)
  if (is.null(r$weights) || !NROW(r$weights)) stop("qpadm: no weights"); "" }, error = function(e) conditionMessage(e))
qps_rtools <- function() { h <- Sys.getenv(sprintf("RTOOLS%s_HOME", QPS_RT), sprintf("C:/rtools%s", QPS_RT)); mk <- file.path(h, "usr", "bin", "make.exe")
  if (file.exists(mk)) return(invisible(TRUE))
  f <- tryCatch({ x <- readLines(QPS_RTOOLS, warn = FALSE); v <- unique(unlist(regmatches(x, gregexpr(sprintf("rtools%s-[0-9]+-[0-9]+\\.exe", QPS_RT), x))))
    v[order(as.integer(sub("^rtools[0-9]+-([0-9]+)-.*$", "\\1", v)), decreasing = TRUE)][1] }, error = function(e) NA_character_)
  if ((is.na(f) || !nzchar(f)) && QPS_RT == "45") f <- "rtools45-6768-6492.exe"
  if (is.na(f) || !nzchar(f)) qps_dur("Rtools%s bulunamadı. https://cran.r-project.org/bin/windows/Rtools/ adresinden R sürümünüze uygun Rtools'u kurup bu dosyayı yeniden çalıştırın.", "Rtools%s not found. Install the Rtools matching your R version from https://cran.r-project.org/bin/windows/Rtools/ and run this file again.", QPS_RT)
  qps_m("    Rtools%s indiriliyor: %s (yaklaşık 450 MB; uzun sürebilir)...", "    Downloading Rtools%s: %s (about 450 MB; this can take long)...", QPS_RT, f)
  out <- file.path(tempdir(), f); ok <- tryCatch(utils::download.file(paste0(QPS_RTOOLS, f), out, mode = "wb", quiet = FALSE) == 0, error = function(e) FALSE)
  if (!ok) qps_dur("Rtools%s indirilemedi. https://cran.r-project.org/bin/windows/Rtools/ adresinden kendiniz kurup bu dosyayı yeniden çalıştırın.", "Rtools%s could not be downloaded. Install it yourself from https://cran.r-project.org/bin/windows/Rtools/ and run this file again.", QPS_RT)
  qps_m("    Rtools%s kuruluyor (birkaç dakika; Windows yönetici izni isteyebilir)...", "    Installing Rtools%s (a few minutes; Windows may ask for administrator permission)...", QPS_RT)
  system2(out, c("/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/SP-"), wait = TRUE); unlink(out)
  if (!file.exists(mk)) qps_dur("Rtools%s kurulamadı (%s yok). https://cran.r-project.org/bin/windows/Rtools/ adresinden kendiniz kurun.", "Rtools%s could not be installed (%s missing). Install it yourself from https://cran.r-project.org/bin/windows/Rtools/.", QPS_RT, mk)
  invisible(TRUE) }
qps_admixtools <- function() { ek <- qps_adx_eksik(); if (!length(ek)) { qps_m("    admixtools: tamam (%s).", "    admixtools: OK (%s).", utils::packageVersion("admixtools")); return(invisible(TRUE)) }
  qps_m("    admixtools kuruluyor / güncelleniyor (eksik: %s)...", "    Installing / updating admixtools (missing: %s)...", paste(utils::head(ek, 6), collapse = ", "))
  if (.Platform$OS.type == "windows") { qps_m("    Hazır Windows paketi deneniyor (%s)...", "    Trying the ready-made Windows package (%s)...", QPS_RUNIV)
    try(utils::install.packages("admixtools", lib = .libPaths()[1], repos = c(QPS_RUNIV, getOption("repos")), type = "binary"), silent = TRUE)
    ek <- qps_adx_eksik(); if (!length(ek)) return(invisible(TRUE)) }
  qps_m("    Hazır paket yok ya da eksik; kaynaktan derlenecek (Rtools%s gerekir; 10-20 dakika sürebilir).", "    No suitable ready-made package; building from source (needs Rtools%s; may take 10-20 minutes).", QPS_RT)
  if (.Platform$OS.type == "windows") qps_rtools()
  if (!qps_var("remotes")) qps_kur("remotes")
  remotes::install_github("uqrmaie1/admixtools", ref = QPS_ADX_SHA, lib = .libPaths()[1], upgrade = "never", dependencies = NA, build_vignettes = FALSE, force = TRUE)
  ek <- qps_adx_eksik(); if (length(ek)) qps_dur("admixtools kurulamadı ya da eksik işlev var: %s", "admixtools could not be installed or functions are missing: %s", paste(ek, collapse = ", "))
  invisible(TRUE) }
qps_main <- function() {
  options(repos = c(CRAN = "https://cloud.r-project.org"), timeout = max(3600, getOption("timeout")), install.packages.compile.from.source = "never")
  qps_lib(); dir <- Sys.getenv("QPS_DIR"); prog <- Sys.getenv("QPS_PROG")
  cp <- qps_calisan(dir)   # v6.4: calisan kopya (port dosyasi ya da tercih edilen port, HTTP isaretiyle)
  if (!is.na(cp)) { url <- sprintf("http://127.0.0.1:%d", cp); qps_m("Program zaten açık; tarayıcıda açılıyor: %s", "The program is already running; opening it in the browser: %s", url); utils::browseURL(url); return(invisible(0)) }
  qps_m("    R %s, paket klasörü: %s", "    R %s, package folder: %s", getRversion(), .libPaths()[1])
  e <- qps_eksik_paket()
  if (length(e)) { qps_m("    Eksik paketler kuruluyor (ilk kurulumda 5-15 dakika sürebilir)...", "    Installing missing packages (5-15 minutes on the first install)...")
    if ("rlang" %in% e) qps_kur("rlang"); qps_kur(setdiff(e, "rlang"))
    e <- qps_eksik_paket(); if (length(e)) qps_dur("Kurulamayan paketler: %s", "Packages that could not be installed: %s", paste(e, collapse = ", ")) }
  qps_m("    Paketler: tamam.", "    Packages: OK.")
  qps_m("[4/5] admixtools denetleniyor...", "[4/5] Checking admixtools...")
  qps_admixtools()
  d <- qps_adx_dene(); if (nzchar(d)) qps_dur("admixtools yüklendi ama işlev denetimi başarısız: %s", "admixtools is installed but the function check failed: %s", d)
  qps_m("    admixtools işlev denetimi: tamam.", "    admixtools function check: OK.")
  qps_m("[5/5] Program başlatılıyor: %s", "[5/5] Starting the program: %s", prog)
  port <- qps_bos_port()   # v6.4: 7654 doluysa 7655-7699
  if (is.na(port)) qps_dur("7654-7699 portlarının hepsi başka programlarca kullanılıyor; birini kapatıp bu dosyayı yeniden çalıştırın.", "Ports 7654-7699 are all used by other programs; close one and run this file again.")
  if (port != QPS_PORT) qps_m("    Port %d başka bir program tarafından kullanılıyor; %d kullanılacak.", "    Port %d is used by another program; %d will be used.", QPS_PORT, port)
  url <- sprintf("http://127.0.0.1:%d", port); Sys.setenv(QPS_PORT = port, QPS_LAUNCHER = "bat")
  setwd(dir); app <- source(file.path(dir, prog), encoding = "UTF-8")$value
  qps_m("Program tarayıcıda açılıyor: %s -- kapatmak için programdaki \"Programı kapat\" düğmesini kullanın ya da sekmeyi kapatın.", "The program opens in the browser: %s -- to stop it, use \"Close the program\" in the program or close the tab.", url)
  shiny::runApp(app, port = port, launch.browser = TRUE)
  invisible(0) }
if (!nzchar(Sys.getenv("QPS_BAT_SINAMA"))) tryCatch(qps_main(), error = function(e) qps_dur("Hata: %s", "Error: %s", conditionMessage(e)))
