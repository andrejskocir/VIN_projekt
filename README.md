# Sistem za spremljanje nivoja vode 

<p float="left">
<img src="Photo-5015.jpg" alt="Sistem v praksi" width="200"/>
<img src="img1.png" alt="Aplikacija" width="200"/>
</p>



## Ideja: 
Želel sem sistem, ki me opozori ko je gladina vode v kadi na želeni višini in grem lahko brez vmesnega pogledovanja mirno iz moje sobe v kopalnico. 

## Izvedba: 
Projekt uporablja ultrazvočni senzor za merjenje razdalje do predmetov, v tem primeru globine vode v kadi. Meritve so prikazane v realnem času na LCD zaslonu, ki je povezan z mikrokrmilnikom STM32. Dodatno projekt vključuje Bluetooth modul HM-10, ki omogoča brezžično pošiljanje meritev razdalje na aplikaciji narejeni v ogrodju Flutter na Android napravi. Z uporabo aplikacije na mobilni napravi lahko prejemam podatke o razdalji v realnem času, kar omogoča enostavno spremljanje in analizo meritev na daljavo. Ta funkcionalnost prinaša dodano vrednost v situacijah, kjer ni praktično ali možno nenehno spremljati LCD zaslona na mikrokrmilniku. 

## Komponente:  
 - STM32F3DISCOVERY razvojna plošča 
 - ultrazvočni senzor (HC-SR04) 
 - HM-10 BLE 4.0 Bluetooth module 
 - LCD zaslon - I2C 1602 LCD Display Module 16X2 
