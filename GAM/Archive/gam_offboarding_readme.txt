support_stuff/GAM/gam_offboarding.sh

 
 instalacja:
 - pobrać gdzie bądź
 - w lokalizacji pliku nalezy odpalić w terminalu "chmod +x gam_offboarding.sh"
   plik zostanie zmieniony na wykonywalny i bedzie można go uruchamiać w konsoli
 - WAZNE - zastąpic wystapienia "dawid.brygier" swoim userem
 - dodać ścieżkę do skryptu w konfigu basha:
   w terminalu wpisać:
   
              "nano ~/.bash_profile"
          lub "nano /etc/zshrc"
              
   dodać alias dlo skrytpu, np.:
   
              alias offboarding='~/GAM/gam_offboarding.sh'
              
   zapisać zmiany

  działanie:
 - robi co trzeba w g-suite. Zmiana hasla odpina dysku, usuwa z grup. kopia plików do lidera, delegacja skrzynki, transfer eventów ze zwolnieniem resourców.

  użycie: 
  - bash gam_offboarding_script.sh old.user leader.name
