# INSTALLATION
PAS 1 - DOWNLOAD
  1) Varianta exportata a aplicatiei poate fi luata de pe one drive:
  
		https://1drv.ms/f/s!ArKYQdcc4mqdiscqH1sH9YYVwCbT8A
	Link-ul trimite catre un folder care contine toate variantele exportate ale fiecarui modul: (Creare lectie, Creare tema, Creare test, EzGraphs - Proiect intreg)
	Folderele sunt denumite dupa regula:
  
  [Nume modul] . [Sistem operare][Numar biti]
  
  Pentru un calculator 64 biti cu Windows se alege:
	[EzGraph] . windows64
	
  2) De asemenea trebuie downloadat fisierul ezgraphs.sql de pe github (acelasi link ca mai sus) din folderul "SQL export file".
	
  3) Instalati unul din programele "XAMPP" sau "WampServer":
	XAMPP: https://www.apachefriends.org/ro/index.html
	WampServer: http://www.wampserver.com/en/

PAS 2 - CONFIGURARE DATABASE

Porneste programul instalat la pasul 3) si pe browser la pagina "localhost/phpmyadmin" creeaza un database cu numele "ezgraphs".

Apoi din meniul de sus, optiunea import, selecteaza fisierul downloadat la pasul 2).

Apasa GO.

PAS 3 - RULEAZA APLICATIA

# EzGraphs
Aplicatia “EzGraphs” vine in ajutorul elevilor pentru a invata si a intelege mai usor fascinantul capitol al grafurilor cu lectii, exemple, jocuri si teste. De asemenea, vine in ajutorul profesorilor care vor putea sa monitorizeze mai usor evolutia elevilor prin crearea de clase, teste si teme specifice si lectii. Desenele cu grafuri orientate si neorientate pot fi create sau modificate interactiv in cadrul lectiilor si al temelor date prin adaugare, stergere, mutare de noduri si/sau muchii/arce. Odata cu modificarea interactiva a unui graf, sunt actualizate automat toate exemplele care corespund grafului din lectia respectiva, cum ar fi: matricea de adiacenta, listele de adiacenta, gradele varfurilor, lanturi/drumuri, cicluri/circuite, parcurgeri (DF/BF), componente conexe etc. In cadrul lectiilor avem posibilitatea de a descarca algoritmii specifici si de a ii rula (cum ar fi parcurgeri(DF/BF), componente conexe, lanturi/drumuri etc.) si de ii vizualiza pe graful nostru prin colorare de muchii si noduri in ordinea parcurgerii.
