import std/[os, osproc, strutils, posix, random, times]

const 
  LOCK_FILE = "/tmp/wallpaper.lock"
  shit = "Gather black hedgehogs strength 收集黑刺猬的力量 invade floating death fortress 侵略浮动死亡要塞 run fast for lumberjack website 为伐木工人网站快速运行 die to poor mistake 死于可怜的错误 return next circus 返回下一个马戏团"

  IMAGE_EXT = [
    ".jpg", ".jpeg", ".png"
  ]

proc lockExists: bool {.inline.} =
  fileExists(LOCK_FILE)

proc createLock {.inline.} =
  writeFile(
    LOCK_FILE,
    shit
  )

proc getWallpaper: string {.inline.} =
  var 
    files: seq[string]
    morning, afternoon, evening, night: seq[string]
  
  for k, p in walkDir(getHomeDir() / "Wallpapers"):
    if k == pcFile and p.splitFile().ext in IMAGE_EXT:
      files.add(p)

  for file in files:
    let name = file.splitFile().name

    if name.endsWith("morning"):
      morning.add(file)
    elif name.endsWith("afternoon"):
      afternoon.add(file)
    elif name.endsWith("evening"):
      evening.add(file)
    elif name.endsWith("night"):
      night.add(file)
    else:
      echo "wallpaper: uncategorized wallpaper: " & file
  
  let hour = now().hour()

  case hour
  of {19..23}, {0..5}:
    echo "wallpaper: picking from a night wallpaper"
    return night.sample()
  of {6..12}:
    echo "wallpaper: picking from a morning wallpaper"
    return morning.sample()
  of {13..15}:
    echo "wallpaper: picking from an afternoon wallpaper"
    return afternoon.sample()
  of {16..18}:
    echo "wallpaper: picking from an evening wallpaper"
    return evening.sample()

proc swaybg(wallpaper: string) {.inline.} =
  discard execCmd("killall swaybg")

  echo "wallpaper: forking!"
  let next = fork()
  
  #echo "prev -> " & $prev & ' ' & "next -> " & $next
  if next < 0:
    quit "wallpaper: failed to fork! (" & $next & ')'
  
  if next == 0:
    echo "wallpaper-slave: forked; running swaybg"
    discard execCmd(
      "swaybg -i " & wallpaper 
    )
    echo "wallpaper-slave: removing lock file"
    removeFile(LOCK_FILE)
    quit 0

  echo "wallpaper: fork successful!"

proc death {.noconv.} =
  echo "Removing lock file"
  removeFile(LOCK_FILE)

  quit 1

proc main {.inline.} =
  setControlCHook(death)

  if lockExists():
    quit "Won't run further, lock already exists: " & LOCK_FILE
  
  echo "Creating lock!"
  createLock()

  var wallpaper: string

  if paramCount() > 0:
    wallpaper = paramStr(1)
  else:
    wallpaper = getWallpaper()

  if not fileExists(wallpaper):
    quit "Invalid wallpaper path: " & wallpaper
  
  while true:
    swaybg(wallpaper)
    sleep 3600000 # sleep for 1 hour

when isMainModule:
  main()
