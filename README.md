# Temperature-Sensor
A fan will work when the temperature exceeds 50 Celsius and will stop when the temperature return below 50. Also there is LCD to display the time period when the fan work.


# Calculations
- We used a crystal with frequency 8MHz. So, if we want to increment the counter every second we will make 250 interrupts.
- We also used pre scalar of 32.
- Timer interrupt delay Time = (π·ππππππππβ(πππβπ»π΄πΉπ)) / (π­πΆπΊπͺ/π) = (ππ β (πππβπ)) / ((πβ1000000)/π) = 4 / 1000 seconds
- No. Interrupts = 1000 / 4 = 250
# Screenshot
![2](https://user-images.githubusercontent.com/68257208/113745493-a1327000-9705-11eb-9632-c1104ac41991.png)
