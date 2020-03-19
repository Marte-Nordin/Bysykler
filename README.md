# Bysykler

Dette er del av en jobbsøknad, hvor case er løst vha R-koding og visualisering i PowerBI.

For å kjøre R-skriptet, må R være installert, RStudio er brukergrensesnittet som gjør det enklere å jobbe med koden.
Koden mangler infrastruktur. Med dette menes at skriptet henter data fra et API, lagrer til en mappe som ikke er standard for alle PCer, da jeg forstod det slik at det uansett potensielt er Mac- og Linux-brukere som skal se på koden.
I tillegg er det ikke satt opp løsning for konstant oppdatering av dataene i Power BI-filen, og denne er satt til å lese en fil lokalt på utviklers PC, så path må endres hvis andre benytter koden og vil oppdatere dashboardet.

Det er blitt valgt å holde stien til filområdet identisk for R-skriptet og PowerBI-filen, for at dette er konsekvent. Løsningen kan derfor ikke prodsettes før filområdene er endret.

For bruk av kode: 
Endre nederste linje i R-skriptet til ønsket filområde.Kjør koden, og endre stien i Power BI-filen til å lese fra oppdatert sti.


Programmer for å benytte filene:
R:
https://cran.r-project.org/bin/windows/base/

RStudio:
https://rstudio.com/products/rstudio/download/

Power BI Desktop:
https://powerbi.microsoft.com/en-us/downloads/
