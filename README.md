# hack-a-chair
![alt tag](http://i65.tinypic.com/aph4qg.jpg)

The project objective is to help users have a correct sitting posture. This is achieved by alerting trough desktop notifications for any incorrect posture cases.

Given a 90 degrees angle of the chair, 3 sensors will report for any back irregularity - 2 for the upper region and 1 for the low back (lumbar) region.
Similarly, both legs are to be in permanent contact with the edge of the sitting area - 2 sensors will report for any not recommended legs posture (crossed legs, knees upper than backside due to improper chair height)

The alerting system provides an extra alert in case the user sits for more than 50 minutes, suggesting the user to take a walk :)

Also note that any short (<10s) posture change will not trigger an alert, thinking that the user might intentionally want to get out of the static mode.

There’s also a browser user interface that points out via images the user’s current chair position vs the recommended position.

The project offers support for scheduled/on demand reports in terms of:
- percentage of the incorrect posture time throughout a day
- counting of the unfollowed sitting timeouts recommendations
- graphics of the posture fluctuation during a day
- overall sitting time during a day
- overall brake time during a day

Development details:

1. Hardware: Arduino, pressure sensors, bending sensors
2. Software: Ruby, Mongo, Angular, Push notifications
