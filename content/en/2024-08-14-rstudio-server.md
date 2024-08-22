---
title: RStudio Server
date: '2024-08-14'
slug: rstudio-server
---

After moving the workstation from LSU to University of Arizona, I could not get access to it after plugging it to the Ethernet. So, I asked the university ITS group to help. They opened the `8787` portal on the university network, I then can access it via `https:://ip_address:8787` with the university VPN. Everything worked well.

Until we need to move it to a nearby room as it was initially put in another professor's office. After moving to my office, I could not get access to it anymore. We then tried to put it back to that professor's office, and still no luck!! This is quite puzzling as we did not change anything.

UITS team came and made sure that it is all good on the university network side. So it must by the problem from the workstation. Sure it was. And the following command solved it! Sort of weird as we did not change anything!

```bash
sudo firewall-cmd --permanent --add-port 8787/tcp
```

