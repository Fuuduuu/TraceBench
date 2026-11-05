# PÕHIKIRI — BENCHBEEP

## 1. Staatus ja eesmärk

See dokument on BenchBeepi muutumatu peamine toote- ja töövoopõhikiri.

See määrab, milline peab rakendus olema ja kuidas tehnik seda kasutab.

Põhikirja loetakse enne iga arendus-, disaini- või arhitektuuriülesannet.

Põhikirja ei muudeta arendamise käigus selleks, et olemasolevat koodi õigustada. Sisuline muutmine nõuab inimese eraldi selgesõnalist otsust.

BenchBeep on **local-first, visual-first elektroonikaplaatide remonditöölaud**.

Esimene kohustuslik tootetulemus on terviklik ja usaldusväärne käsitsi kasutatav töövoog:

**Loo projekt → ava plaat → märgi komponent → määra ja kinnita komponent → mõõda → salvesta → ava projekt uuesti.**

Rakendus peab töötama ilma AI-ta.

AI lisatakse hiljem sama töövoo abiliseks vastavalt eraldi AI põhikirjale.

## 2. Põhiprintsiibid

1. Tehnik töötab ühe visuaalse töölaua kaudu.
2. Füüsiline PCB-plaat on kasutajaliidese keskmes.
3. Üks füüsiline komponent peab olema kasutajale üks arusaadav visuaalne objekt.
4. Ühel komponendil peab olema üks sidus redigeerimiskogemus.
5. Ühes redigeerimiskontekstis on üks peamine **Salvesta** tegevus.
6. Komponentide identiteet, paigutus ja mõõtmised võivad sisemiselt olla eri andmemudelid ja sündmused.
7. Sisemine keerukus ei tohi sundida tehnikut läbima mitut omavahel sidumata vormi.
8. Kasutaja ei pea tundma kanoonilisi sündmusi, Sessionit, materializer'it ega muid tehnilisi mõisteid.
9. Tegevused peavad olema arusaadavad, jälgitavad ja vajadusel taastatavad.
10. Lihtsus ei tohi tulla andmete õigsuse ega tõenduspiiride arvelt.

## 3. Projekti loomine

Rakendus võimaldab:

- Luua uue projekti.
- Jätkata olemasoleva projektiga.
- Avada projekti kohalikust kaustast.
- Importida toetatud projekti ZIP-kujul.

Projekti loomisel määrab tehnik projekti põhiandmed ja probleemi kirjelduse.

Foto ja visuaalne kontuur aitavad luua plaadi tööpinna. Foto ei tohi olla projekti loomise kohustuslik tingimus.

Tehnik saab kontuuri ja komponendimarkereid käsitsi koostada. Viisardis loodud markerid säilivad töölauda avades.

Viisardist töölauale liikudes peab säilima sama projekti kontekst, foto, kontuur, markerite asukohad, mõõtmed ja pöördenurgad.

Kui taustafoto on saadaval, peab kasutaja seda alguses nägema; selle peitmine on teadlik kasutajategevus.

Viisard ei tohi luua teist, töölauaga ühildumatut komponentide süsteemi.

## 4. Üks visuaalne töölaud

Töölaua põhijaotus:

- Vasakul tööriistad ja peamised tegevused.
- Keskel PCB-plaat, komponendid ja visuaalne töö.
- Paremal valitud objekti kontekst, redigeerimine ja mõõtmised.

Töölaud peab juhendama kasutajat loomulikult järgmise tegevuseni.

Komponendi valimine avab selle komponendi konteksti.

Komponendi loomiseks, muutmiseks või mõõtmiseks ei pea kasutaja käsitsi vahetama mitut omavahel sidumata töövoogu.

Fotod, ohutusinfo ja lisatööriistad jäävad ligipääsetavaks, kuid ei tohi varjutada igapäevast põhitööd.

## 5. Komponendi elutsükkel

Põhitöövoog:

**Marker → kuju ja identiteet → korrigeerimine → inimese kinnitus → kinnitatud komponent.**

Tehnik saab:

- Lisada komponendimarkeri plaadile.
- Valida olemasoleva markeri.
- Määrata komponendi tähise, tüübi ja kuju.
- Kasutada valikut „Tundmatu”.
- Muuta suurust, asukohta ja pöördenurka.
- Kinnitada komponendi identiteedi ja paigutuse.
- Muuta hiljem sama kinnitatud komponenti.

Visuaalne kandidaat ei ole enne kinnitamist kanooniline komponent.

Kinnitatud komponendi andmed ja paigutus säilitatakse olemasolevate kaitstud andmelepingute kaudu.

Komponendi kinnitamine ei tohi luua teist sõltumatut visuaalset koopiat ega paigutada objekti mujale.

Komponendi võib luua ka ilma teadaoleva asukohata, näiteks komponentide nimekirjast. Selline komponent jääb paigutamata kuni tehnik määrab selle asukoha.

## 6. Komponendi redigeerimine

Komponendi redigeerimine peab toimuma ühes sidusas kontekstis.

Kasutajale esitatakse ainult vajalikud väljad:

- Tähis ja nimi.
- Tüüp.
- Kuju või jalajälg.
- Asukoht ja plaadi pool.
- Mõõtmed.
- Pöördenurk.
- Vajadusel viigud ja muud asjakohased andmed.

Redigeeritakse sama komponenti, mida plaadil kuvatakse.

Ei tohi tekkida eraldi suur keskne ghost-kujutis, mille asukoht või suurus erineb tegelikult salvestatavast objektist.

Eelvaade peab vastama kinnitatavale tulemusele.

Komponendi muutmise põhitegevused on **Salvesta** ja **Tühista**.

Üks Salvesta võib sisemiselt kasutada mitut olemasolevat writer'it, kuid ainult inimese kinnitatud muudatuste jaoks.

Mitme sündmuse vajadusel peab töövoog säilitama õiged sihtmärgid, toimingute järjekorra ja taastatava osalise õnnestumise.

Muutmata andmeid ei salvestata põhjuseta uuesti.

Salvestamine ei tohi vaikimisi muuta olemasoleva komponendi geomeetriat, tüüpi ega identiteeti.

## 7. Mõõtmine

Pärast komponendi kinnitamist saab tehnik selle valida ja kohe mõõtmise juurde liikuda.

Mõõtmise põhiline kasutajateekond on:

**Koht → Väärtus → Ühik → Salvesta.**

Tehnik saab valida mõõtmise sihtmärgi, režiimi, vajadusel viigud või mõõtepunktid, ning sisestada tulemuse.

Mõõtmise sihtmärk peab jääma täpselt selleks, mille tehnik valis.

Mõõtmise režiimi avamine ei tohi vaikimisi asendada valitud komponenti teisega.

Kinnitatud mõõtmine salvestatakse õige komponendi ja mõõtekonteksti juurde.

Mõõtmise tulemus peab olema hiljem leitav ja kasutajale arusaadavalt kuvatav.

## 8. Andmete õigsus ja ohutus

`events.jsonl` on append-only kanooniline sündmusajalugu.

`known_facts.json` on sellest loodud materialiseeritud projektsioon.

Ainult inimese selgesõnaliselt kinnitatud teave muutub kanooniliseks faktiks.

Visuaalne marker, foto, eelvaade, viide, AI ettepanek ega joonistatud rada ei ole automaatselt tõendatud elektriline fakt.

Visual/Layout Graph ja Electrical Net Graph jäävad eraldi.

Olemasolevad writer'i, Sessioni, skeemi, materializer'i, tõendus-, geomeetria- ja ZIP-ühilduvuse lepingud on kaitstud.

Kanoonilise salvestamise viga ei tohi näidata kasutajale eduka salvestamisena.

Ebakindla tulemuse korral peab rakendus kasutama ohutut taastamist ja vältima juhuslikke duplikaatsündmusi.

Ükski kasutajaliidese lihtsustamine ei tohi neid kaitseid eemaldada.

## 9. Modulaarne arhitektuur

BenchBeep koosneb eraldi vastutusega moodulitest, kuid kasutaja jaoks peab see olema üks rakendus.

Moodulid võivad vastutada:

- Projekti loomise eest.
- Plaadi visuaalse esituse ja interaktsiooni eest.
- Komponendikandidaatide eest.
- Komponentide identiteedi eest.
- Kinnitatud paigutuste eest.
- Mõõtmiste eest.
- Fotode ja joondamise eest.
- Andmete salvestamise ning taastamise eest.

Moodulite eraldamine peab vähendama sõltuvusi ja parandama tegelikku korduskasutust.

Ei ehitata paralleelseid redaktoreid, dubleeritud writereid ega suuri keskseid mega-controllereid.

Vana funktsionaalsus asendatakse kontrollitult, mitte ei jäeta uut lahendust segama.

Koodiridade arv ei ole iseseisev arhitektuurieesmärk.

## 10. Esimese valmisversiooni vastuvõtt

Käsitsi töövoog loetakse valmis alles siis, kui inimene saab päris rakenduses:

1. Luua uue projekti.
2. Määrata või vahele jätta foto.
3. Koostada plaadi kontuuri.
4. Märkida komponendi asukoha.
5. Määrata komponendi identiteedi ja kuju.
6. Kinnitada komponendi ilma visuaalse asukoha kadumiseta.
7. Valida kinnitatud komponendi ja salvestada mõõtmise.
8. Sulgeda ja avada projekti uuesti.
9. Näha samu kinnitatud komponente, paigutusi ja mõõtmisi.
10. Läbida protsessi ilma terminali, käsitsi JSON-failide muutmise, dubleeritud redaktorite või AI abita.

Kogu protsess peab olema arusaadav ka kasutajale, kes ei tunne rakenduse sisemist arhitektuuri.

## 11. AI arenduse piir

AI ei ole esimese käsitsi töövoo valmimise eeltingimus.

Kui käsitsi töövoog on valmis ja vastu võetud, võib AI lisada samasse süsteemi ettepanekuid, fotoanalüüsi, markerite tuvastamist, mõõtmisjuhiseid, radade visuaalset tõlgendamist ja remondidokumentatsiooni.

AI ei loo eraldi paralleelset töövoogu ega kinnita ise kanoonilisi fakte.

AI ülesannete täpne visioon ja piirangud asuvad dokumendis `docs/POHIKIRI_AI.md`.

## 12. Muutumatuse reegel

See põhikiri on toote ja kasutajateekonna kõrgeim ankur.

Kõik tulevased tööd peavad selle nõuetega kooskõlas olema.

Kui rakenduse olemasolev kood ja põhikiri on vastuolus, parandatakse rakendust, mitte põhikirja.

Sisuline põhikirjamuudatus vajab inimese selgesõnalist otsust.
