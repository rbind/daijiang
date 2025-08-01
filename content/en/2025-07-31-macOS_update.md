---
title: macOS update issue
date: '2025-07-31'
slug: macos_update
---

After updating macOS to Sequoia Version 15.6 (24G84), I noticed that I cannot interact with the Finder from any other Applications. For example, I cannot export files from `Photos.app`, I cannot upload files to `Google Chrome` or `Safari`, I cannot exclude folders from `TimeMachine` when backup the computer. Whenever I click on the uploading or exporting or excluding box, there is a spin of the colorful ball, and after about 10 seconds, nothing happended.

I got really frustrated, and was almost ready to downgrade the whole system back to an earlier version. After doing some search (AI answer did not help), I found this one solved my issue: https://apple.stackexchange.com/a/474043/

Essentially, I just need to remove the cache of `FileProvider` (the name makes sense now after came across with this issue).

```bash
rm -r ~/Library/Application\ Support/FileProvider/*
```

Then restart the Applications, and it now can interact with the Finder file system!!! Saved me a day.

And, btw, we have finally arrived at Madison, WI yesterday. I may can write a short blog post about the whole process later.

