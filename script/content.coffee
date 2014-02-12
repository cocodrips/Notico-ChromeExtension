favicon = null
isTarget = true

window.onload =  () ->
  try
    favicon = new Favico({
      animation : 'fade'
      noticofication: 'jump'
      bgColor : '#0d0',

    })
    favicon.badge(0);
    target = document.getElementsByTagName('title')[0]
    config = {
      subtree: true,
      characterData: true,
      childList: true
    }
    observer = new WebKitMutationObserver( (mutations)->
      if(isTarget)
        notico.changeTitle(mutations)
    )
    observer.observe(target, config)

notico = {}
notico.isDisplayedBadge = false
notico.changeTitle = (mutations) ->
  if mutations.length > 0
    if !mutations
      isTarget = false
      return

    title = mutations[0].target.data
    badgeNum = notico.badgeNum(title)
    console.log badgeNum
    if badgeNum < 1
      notico.resetBadge()
      return
    notico.displayBadge(badgeNum)


notico.badgeNum = (str) ->
  m = str.match(/^\(([0-9]+)\)/)
  if m
    return Number(m[1])
  return -1

notico.displayBadge = (num) ->
  try
    favicon.badge(num)
  catch
    isTarget = false

notico.resetBadge = () ->
  favicon.reset()








