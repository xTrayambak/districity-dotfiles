import std/[os, osproc, strutils, random]

const 
  LOCK_FILE = "/tmp/wallpaper.lock"
  shit = [
    """
# I would like to invite Mr. LowTierGod to give a motivational speech on life now.
Your life literally is as valuable as a summer ant. I'm just gonna stomp you, you're gonna keep coming back, I'm gonna seal up all my cracks, you're gonna keep coming back, why? Cause you keep smelling the syrup, you worthless bitchass <censored by Tray Corporation>! You're gonna stay on my dick until you die. You serve no purpose in life, your purpose in life is to be on my stream sucking on my dick daily. Your purpose in life is to be in that chat blowing a dick daily. Your life is nothing, you serve ZERO purpose. You should kill yourself, NOW! And give somebody else a piece of that oxygen and ozone layer that's covered up so we can breathe inside this blue trapped bubble. Cause what are you here for? To worship me? Kill yourself! I mean that with a hundred percent with a thousand percent.
""",
  """
My son is three years old, and we've been trying to potty train him for a while now. Unfortunately, we've hit a major roadblock - his fear of the "skibidi toilet"
You might be wondering what a "skibidi toilet" is, and honestly, I had no idea either until we encountered it. Fron what I've gathered, "skibidi toilet" is basically a new genre of youtube video about evil singing toilets. Basically think zombies but instead they're toilets that sing in your face. I was fine to let my son watch the videos at first, as they seemed innocent enough and fairly harmless, but they soon devolved into strange post apocalyptic material with grotesque toilets fighting in a war against mankind, so I finally intervened and cut him off.
I thought that was the end of it, he can't watch the videos anymore so theres nothing to be afraid of. Well, I was wrong. This has since turned into a complete nightmare for us at home. We recently started potty training and he refuses to use the toilet now due to skibidi toilet. Whenever we try to put him on it he screams and refuses to go anywhere near it. We've tried explaining that skibidi toilet isnt real and our toilet is completely safe, but it seems like it's too overwhelming for him. We even let him decorate it with stickers, hoping it would make him less afraid, but no luck so far. It utterly breaks my heart to see him so anxious about such a simple thing that every child goes through.
I'm not sure how to proceed from here. Should we give him more time and hope that he warms to the toilet, or is it better to try a completely different approach? I know every child is different, but has anyone else experienced something similar? How did you deal with skibidi toilet in your household, if you encountered it?
""",
  """
No, Richard, it's 'Linux', not 'GNU/Linux'. The most important contributions that the FSF made to Linux were the creation of the GPL and the GCC compiler. Those are fine and inspired products. GCC is a monumental achievement and has earned you, RMS, and the Free Software Foundation countless kudos and much appreciation.
Following are some reasons for you to mull over, including some already answered in your FAQ.
One guy, Linus Torvalds, used GCC to make his operating system (yes, Linux is an OS -- more on this later). He named it 'Linux' with a little help from his friends. Why doesn't he call it GNU/Linux? Because he wrote it, with more help from his friends, not you. You named your stuff, I named my stuff -- including the software I wrote using GCC -- and Linus named his stuff. The proper name is Linux because Linus Torvalds says so. Linus has spoken. Accept his authority. To do otherwise is to become a nag. You don't want to be known as a nag, do you?
(An operating system) != (a distribution). Linux is an operating system. By my definition, an operating system is that software which provides and limits access to hardware resources on a computer. That definition applies whereever you see Linux in use. However, Linux is usually distributed with a collection of utilities and applications to make it easily configurable as a desktop system, a server, a development box, or a graphics workstation, or whatever the user needs. In such a configuration, we have a Linux (based) distribution. Therein lies your strongest argument for the unwieldy title 'GNU/Linux' (when said bundled software is largely from the FSF). Go bug the distribution makers on that one. Take your beef to Red Hat, Mandrake, and Slackware. At least there you have an argument. Linux alone is an operating system that can be used in various applications without any GNU software whatsoever. Embedded applications come to mind as an obvious example.
Next, even if we limit the GNU/Linux title to the GNU-based Linux distributions, we run into another obvious problem. XFree86 may well be more important to a particular Linux installation than the sum of all the GNU contributions. More properly, shouldn't the distribution be called XFree86/Linux? Or, at a minimum, XFree86/GNU/Linux? Of course, it would be rather arbitrary to draw the line there when many other fine contributions go unlisted. Yes, I know you've heard this one before. Get used to it. You'll keep hearing it until you can cleanly counter it.
You seem to like the lines-of-code metric. There are many lines of GNU code in a typical Linux distribution. You seem to suggest that (more LOC) == (more important). However, I submit to you that raw LOC numbers do not directly correlate with importance. I would suggest that clock cycles spent on code is a better metric. For example, if my system spends 90% of its time executing XFree86 code, XFree86 is probably the single most important collection of code on my system. Even if I loaded ten times as many lines of useless bloatware on my system and I never excuted that bloatware, it certainly isn't more important code than XFree86. Obviously, this metric isn't perfect either, but LOC really, really sucks. Please refrain from using it ever again in supporting any argument.
Last, I'd like to point out that we Linux and GNU users shouldn't be fighting among ourselves over naming other people's software. But what the heck, I'm in a bad mood now. I think I'm feeling sufficiently obnoxious to make the point that GCC is so very famous and, yes, so very useful only because Linux was developed. In a show of proper respect and gratitude, shouldn't you and everyone refer to GCC as 'the Linux compiler'? Or at least, 'Linux GCC'? Seriously, where would your masterpiece be without Linux? Languishing with the HURD?
If there is a moral buried in this rant, maybe it is this:
Be grateful for your abilities and your incredible success and your considerable fame. Continue to use that success and fame for good, not evil. Also, be especially grateful for Linux' huge contribution to that success. You, RMS, the Free Software Foundation, and GNU software have reached their current high profiles largely on the back of Linux. You have changed the world. Now, go forth and don't be a nag.
""",
  """
Gather black hedgehogs strength 收集黑刺猬的力量 invade floating death fortress 侵略浮动死亡要塞 run fast for lumberjack website 为伐木工人网站快速运行 die to poor mistake 死于可怜的错误 return next circus 返回下一个马戏团
"""
  ]

  IMAGE_EXT = [
    ".jpg", ".jpeg", ".png"
  ]

proc lockExists: bool {.inline.} =
  fileExists(LOCK_FILE)

proc createLock {.inline.} =
  writeFile(
    LOCK_FILE,
    sample(shit)
  )

proc getWallpaper: string {.inline.} =
  var files: seq[string]

  for k, p in walkDir(getHomeDir() / "Wallpapers"):
    if k == pcFile and p.splitFile().ext in IMAGE_EXT:
      files.add(p)

  files.sample()

proc swaybg(wallpaper: string) {.inline.} =
  discard execCmd(
    "swaybg -i " & wallpaper 
  )

proc death {.noconv.} =
  echo "Removing lock file"
  removeFile(LOCK_FILE)

  quit 1

proc main {.inline.} =
  setControlCHook(death)
  randomize()

  if lockExists():
    quit "Won't run further, lock already exists: " & LOCK_FILE
  
  echo "I AM THE ONE WHO LOCKS! >:D"
  createLock()

  var wallpaper: string

  if paramCount() > 0:
    wallpaper = paramStr(1)
  else:
    wallpaper = getWallpaper()

  if not fileExists(wallpaper):
    quit "Invalid wallpaper path: " & wallpaper

  swaybg(wallpaper)
  death()

when isMainModule:
  main()
