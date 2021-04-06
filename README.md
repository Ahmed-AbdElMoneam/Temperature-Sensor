# Temperature-Sensor
A fan will work when the temperature exceeds 50 Celsius and will stop when the temperature return below 50. Also there is LCD to display the time period when the fan work.


# Calculations
- We used a crystal with frequency 8MHz. So, if we want to increment the counter every second we will make 250 interrupts.
- We also used pre scalar of 32.
- Timer interrupt delay Time = 𝑷𝒓𝒆𝒔𝒄𝒂𝒍𝒂𝒓∗(𝟐𝟓𝟔−𝑻𝑴𝑹𝟎)(𝑭𝑶𝑺𝑪/𝟒) = 𝟑𝟐∗(𝟐𝟓𝟔−𝟔)(𝟖∗1000000)/𝟒 = 4 / 1000 seconds
- No. Interrupts = 𝟏𝟒 / 1000 = 250
# Screenshot
![2](https://user-images.githubusercontent.com/68257208/113745493-a1327000-9705-11eb-9632-c1104ac41991.png)
