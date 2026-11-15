# qpAdm Studio

admixtools2 ile qpAdm, rotasyon, f-istatistikleri (f2/f3/f4), qpGraph ve FST analizleri için R/Shiny arayüzü. Geliştiren: mozy70.

## İndirme ve kurulum (Windows)

1. **Code → Download ZIP** ile dosyaları indirin.
2. Zip'i bir klasöre çıkarın (sağ tık → Tümünü ayıkla).
3. `qpAdm Studio BASLAT.bat` dosyasına çift tıklayın. R, paketler ve admixtools eksikse sırayla kurulur, ardından program tarayıcıda açılır.

RStudio ile elle kurulum ve kullanım ayrıntıları: `qpAdm Studio v6.5 Installation.txt` (Türkçe: bölüm A).

## v6.5'te yeni

- allsnps=TRUE ile toplu hedef, sıralı model, ön tanımlı model ve rotasyon koşularında genotip dosyası bir kez okunur; sonuçlar önceki yolla birebir aynı, süre belirgin kısa. Hedef SNP sayısı aynı geçişte sayılır.
- RAW çıktısında her hedefin rcond / matris uyarıları; koşu sürerken indirilen RAW "RUN IN PROGRESS" notu taşır.
- Biriken modeller'de "Aynı setleri seç" ve "Toplu tabloda göster": Right ve Left setleri (etiket ve sample ID) aynı modeller Toplu koşu tablosunda birlikte; tablonun Excel'i.

## Dosyalar

- `qpAdm Studio v6.5.R`: program (tek dosya)
- `qpAdm Studio v6.5 Installation.R`: arayüz paketlerini kuran betik
- `qpAdm Studio v6.5 Installation.txt`: kurulum ve kullanım kılavuzu (TR/EN)
- `qpAdm Studio BASLAT.bat`: Windows için kolay kurulum ve başlatma

---

# qpAdm Studio (English)

R/Shiny GUI for qpAdm, rotation, f-statistics (f2/f3/f4), qpGraph and FST analyses with admixtools2. Developed by mozy70.

## Download and install (Windows)

1. Download the files with **Code → Download ZIP**.
2. Extract the zip to a folder (right-click → Extract All).
3. Double-click `qpAdm Studio BASLAT.bat`. It installs R, the packages and admixtools if they are missing, then opens the program in the browser.

Manual installation with RStudio and usage: `qpAdm Studio v6.5 Installation.txt` (English: section B).

## New in v6.5

- With allsnps=TRUE, batch targets, sequential models, predefined models and rotation read the genotype file once; results are identical to the previous path and runs are much shorter. Target SNPs are counted in the same pass.
- RAW output lists each target's rcond / matrix warnings; a RAW downloaded while a run is in progress carries a "RUN IN PROGRESS" note.
- "Select same sets" and "Show in batch table" in Accumulated models: models with the same Right and Left sets (labels and sample IDs) shown together in the Batch run table; Excel export of the table.

---

## Lisans / License

Telif Hakkı (C) 2026 mozy70

Bu program özgür yazılımdır: Free Software Foundation tarafından yayımlanan GNU Genel Kamu Lisansı sürüm 3 hükümlerine ve aşağıdaki ek şartlara uygun olarak yeniden dağıtılabilir ve/veya değiştirilebilir. Program HİÇBİR GARANTİ OLMAKSIZIN dağıtılmaktadır; ayrıntılar için GNU Genel Kamu Lisansı'na bakınız (`LICENSE`).

GNU GPL v3 madde 7 uyarınca ek şartlar:
(b) "qpAdm Studio by mozy70" yazar atfı, kaynak dosyalarda ve bu programı ya da değiştirilmiş bir sürümünü içeren her eserin gösterdiği yasal bildirimlerde korunmalıdır.
(c) Değiştirilmiş sürümler orijinalden farklı olduğu makul biçimde belirtilerek işaretlenmeli ve orijinal sürüm olarak sunulmamalıdır.

Copyright (C) 2026 mozy70

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3 as published by the Free Software Foundation, with the additional terms below. This program is distributed WITHOUT ANY WARRANTY; see the GNU General Public License for details (`LICENSE`).

Additional terms under GNU GPL v3 section 7:
(b) The author attribution "qpAdm Studio by mozy70" must be preserved in the source files and in the Appropriate Legal Notices displayed by any work containing this program or a modified version of it.
(c) Modified versions must be marked in reasonable ways as different from the original version and must not be presented as the original.
