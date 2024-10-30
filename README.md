# Energy Monitor

This listens for, decodes, and sends electricity usage to an InfluxDB database
so it can be plotted on a Grafana dashboard and MQTT for home automation tools.

The electricity usage data used comes from a LightwaveRF Electricity Monitor
which broadcasts usage over UDP on port 9761.

## Grafana Dashboard

Here is mine.

![](https://camo.githubusercontent.com/81aaeb5da8e99dc9d4f48d7a7ca7c5dbf45b411f/68747470733a2f2f643364656874646d7032727763772e636c6f756466726f6e742e6e65742f6d735f33323438302f66566b57537143653465584e6c6e445446784f6946707775544558324d632f486f6d652532422d25324247726166616e61253242323032302d30352d333025324231352d31312d31312e706e673f457870697265733d31353930383439303030265369676e61747572653d617a353375545a4c636261796d736d53624f7555784c4978666456304865614a4e454f662d454b52646b516932576d47663763364a687a546e5a6b41617a686434747e39706e6c5745584e6143426769646735445839776e747151573734477e4d4d424b593173397237496553374968303536784c50326c396f7733484f4a56474c72354a7a557e617735636a496a6670503444736944356b6950546e6332706c6c704435666f7835366c334a68484c444c56374733527e4f716f7a776a494956455473597a38743554726a4d483568757459775237347952386f30547935596a6b63533761615370572d53566945447a455a705a316b4f636d706379654c347e6f39715573394636674d775952434e6651757a45623230445057616c41434a44304a596c6f66575131674a4b47494448694c7270555439653446447943317363684b7e73747542706e2d34592d554e6352626b57515f5f264b65792d506169722d49643d41504b414a42434759515955524b484247434f41)

## Links

- [LightwaveRF Energy Monitor](https://lightwaverf.com/products/jsjslw600-lightwaverf-electricity-monitor-and-energy-monitor)
- [InfluxDB](https://influxdata.com/time-series-platform/influxdb/)
- [influxdb-ruby](https://github.com/influxdata/influxdb-ruby)
- [ruby-mqtt](https://github.com/njh/ruby-mqtt)
- [Grafana](https://grafana.com/)

## Docker

Included is sample Docker usage based on how I'm running this at home.

```sh
# Build the docker image.
docker build -t energy-monitor .

# Run it, exposing the UDP broadcast port & configuring the target InfluxDB.
docker run -it -p 9761:9761/udp --env INFLUXDB_URL=$INFLUXDB_URL --env MQTT_URL=$MQTT_URL --name energy-monitor energy-monitor

# Save the docker image to a local file, for distribution.
docker save energy-monitor > energy-monitor.tar
```
