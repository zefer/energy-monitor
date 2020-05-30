# Energy Monitor

A LightwaveRF Electricity Monitor broadcasts electricity usage over UDP on port
9761. This listens for it, decodes it, and sends the electricity to an InfluxDB
database so it can be plotted on a Grafana dashboard.

## Links

- [LightwaveRF Energy Monitor](https://lightwaverf.com/products/jsjslw600-lightwaverf-electricity-monitor-and-energy-monitor)
- [InfluxDB](https://influxdata.com/time-series-platform/influxdb/)
- [influxdb-ruby](https://github.com/influxdata/influxdb-ruby)
- [Grafana](https://grafana.com/)

## Docker

Included is sample Docker usage based on how I'm running this at home.

```sh
# Build the docker image.
docker build -t energy-monitor .

# Run it, exposing the UDP broadcast port & configuring the target InfluxDB.
docker run -it -p 9761:9761/udp --env INFLUXDB_URL=$INFLUXDB_URL --name energy-monitor energy-monitor

# Save the docker image to a local file, for distribution.
docker save energy-monitor > energy-monitor.tar
```
