# PÕHIKIRI — TraceBench / BenchBeep

**Mis see fail on:** äpi muutumatu põhikiri — üks tõeallikas skoobi kohta.
**Staatus:** tracked canonical product charter / first-read scope anchor; see ei ole scratch.
Loe see **täielikult läbi enne iga tegevust**. Ükski ettepanek, muudatus ega kood
ei tohi minna vastuollu selle failiga. Kui soov läheb vastuollu — **peatu ja küsi
inimeselt**, ära laienda skoopi vaikimisi.

**See fail ei kasva.** Lubatud on ainult väikesed täpsustused, kui sisu jääb
kompaktseks. Jooksvad detailid ja seis kuuluvad operatiivdokumentidesse
(`CURRENT_STATE.md`, `PASS_QUEUE.md`, `ACTIVE_SCOPE_LOCK.md`), mitte siia.

---

## 1. Põhivisioon

Visual-first repair workbench, kus AI aitab ideest, fotodest ja tehniku tegevusest
teha selge visuaalse töövoo — kuid **AI ei kirjuta ise kinnitatud tõde**. AI on
abiline: suunab ja aitab PCB-plaadi skeemi koostada. AI üksi ei otsusta. **Lõplik
tõde selgub alles tehniku kinnitusel.** AI omapäi ei tee midagi — **kõik tegevused
kutsub esile inimene**.

## 2. Aluspõhimõtted

- Inimene on sensor; AI on graafimootor ja abiline.
- Ainult inimese kinnitatud info muutub äpi faktiks / sündmuseks (canonical event/fact).
- AI pakub, korrastab ja näitab ebakindlust — inimene kinnitab.
- AI võib pakkuda, juhendada ja korrastada; ainult inimese kinnitatud info muutub canonical truth'iks.
- Äpp ei tee „invisible magic" otsuseid; iga fakt on jälgitav inimtegevuseni.

## 3. Õige mudel (töövoo tõde)

See ei ole „AI otsustab ise", ega ka „ehitame Flutteri ekraane ja inimene mõtleb
kõik käsitsi välja". Õige mudel on ahel:

1. **Inimene / tehnik annab:** probleemikirjelduse, foto (AI juhendamisel),
   mõõtmised, tähelepanekud, kahjustatud raja või piirkonna märke (nt HDMI, 12V liin, 5V liin).
2. **AI → visuaalne skeem:** ei märgi komponente ise, vaid paigutab iga komponendi
   asukohale markeri töölauale. Hiljem võib pakkuda ja küsida: „Kas see on transistor?".
3. **Inimene:** klõpsab markeril ja valib õige komponendi või kuju valikmenüüst;
   kui ei tea või pole valikute seas — „Tundmatu".
4. **AI võib pakkuda tõenäosust:** „Arvestades mõõtmisi olen 80% kindel, et tegu on
   takistiga." ja vajadusel nõu anda: „Alusta sellest, kui kaugele jõuab elekter laadimispesast."
5. **Inimene** vaatab, sisestab/parandab, kinnitab või lükkab tagasi.
6. Ainult **kinnitatud info** → äpi fakt / sündmus.
7. Äpp **visualiseerib, juhendab, seob ja mäletab** töö käiku.

## 4. Töövoog (detailid)

**Start:** äpp käivitub stardilehega: „Loo projekt nullist" · „Jätka viimase
projektiga" · „Lae projekt zip-ist või kaustast" · „Seadista telefon piltide tegemiseks".

**„Loo projekt nullist"** küsib järjest:
1. Kontuur — AI joonistab pildi järgi / joonistad ise / vali template.
2. Komponentide asetus — AI märgib pildilt / märgin ise.
3. Kirjelda lühidalt probleemi.

**Kinnitus:** kui kontuur ja markerid on paigas, käib inimene need läbi ja kinnitab
kuju (kui tuvastatav) ja pin-ide asetuse; saab määrata suuruse ja komponenti pöörata.

**Pildistamine:** foto tehakse telefoniga; PCB-plaadil on markerid, mille järgi AI
hindab ligilähedast suurust. AI loeb pildilt komponentide asetuse ja märgib markerid
canvasele; inimene saab markereid liigutada, kustutada ja lisada enne kinnitust.
Telefonile käib väike abiprogramm, mis juhendab pilte tegema.

**Mõõtmised ja rajad:** AI tuvastab, mis suunas rajad jooksevad, ja joonistab
ühendused vastavalt — **rada ei tohi joosta linnulennult** ühest pin-ist teise.
Värvikoodid: 5V punane, 12V sinine, maandus must jne. Värvid valib AI automaatselt;
inimene saab neid seadetest muuta.

**AI mälu:** AI kogub infot nt MD-faili ja märgib sinna iga muudatuse. Jooksvalt
igat muudatust kirja panna pole mõistlik — selleks on nupp „Värskenda AI mälu".

## 5. Äpi keskne pind — visuaalne töölaud

- **Vasakul:** tööriistad / režiimid.
- **Keskel:** dominantne plaat / board canvas / workbench.
- **Paremal:** kontekst — mõõtmised, komponent, ohutus, kandidaadid, ajalugu.

## 6. AI EI tee

1. ei kinnita fakte ilma inimeseta;
2. ei tee automaatset fault diagnosis't tõena;
3. ei tee pildi põhjal net'i;
4. ei tee pildi põhjal elektrilist identiteeti;
5. ei kirjuta canonical events'i ilma confirmita;
6. ei muuda reference-pilti tõendiks;
7. ei tee „invisible magic" otsuseid.

## 7. AI teeb

1. teeb kasutaja ideest visuaali;
2. teeb pildist kandidaadid;
3. loob alternatiivseid UI / workflow pilte;
4. korrastab remondilogi;
5. seob mõõtmised komponentide ja piltidega;
6. leiab vastuolusid;
7. näitab ebakindlust;
8. teeb järgmise-sammu ettepanekuid;
9. genereerib remondikaardi / töökaardi / kokkuvõtte;
10. aitab muuta segase visuaalse info struktureerituks.

## 8. Muutumatuse reegel

See põhikiri on skoobi ankur. Enne igat tegevust loetakse see läbi. Kui midagi
läheb sellega vastuollu, peatu ja küsi inimeselt. Fail ei kasva; sisulised
muudatused vajavad inimese selget otsust.
