import std/[json, os]

const PATH_TO_INTERFACES {.strdefine.} = "/sys/devices/virtual/net"

proc main {.inline.} =
  assert paramCount() > 0

  let bufferString = PATH_TO_INTERFACES / paramStr(1)

  if dirExists(bufferString):
    echo $(%* {
      "text": "󰌆",
      "tooltip": "VPN Enabled"
    })
  else:
    echo $(%* {
      "text": "󰌊",
      "tooltip": "VPN Disabled"
    })

when isMainModule:
  main()
