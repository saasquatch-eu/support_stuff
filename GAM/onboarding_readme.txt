Do działania wystarczy pobrać "onboarding_main.sh

zeby działał jak GAM, to należy dopisac w ./bash_profile lub ./zshrc
alias onb="sicezka_do_pliku"
plik.sh nalezy zmienić na Wykonywalny
chmod 755 sciezka_do_skryptu/plik.sh

Co robi onboarding_main.sh.

Wymusza update skryptu. 
Pobiera nasze repo z gita do tempa, wrzuca poprzednią wersję skryptu do archa,
a na jej miejsce wrzuca tę z repo.

Potem skrypt onboardowy (onb.sh) odpala sie jako subproces.

Na końcu main usuwa pobrane wczesniej repo.
