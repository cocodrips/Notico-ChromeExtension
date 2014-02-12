favicon = null
isTarget = true

newImg = null
#if window.location.href.match('https://twitter.com/')
#  newImg = document.createElement('img')
#  newImg.setAttribute('src', chrome.extension.getURL('imageurl'))

favicon = new Favico({
  animation : 'fade'
  notification: 'jump'
})
favicon.badge(0);

target = document.getElementsByTagName('title')[0]
observer = new WebKitMutationObserver( (mutations)->
  if(isTarget)
    noti.changeTitle(mutations)
)
config = {
  subtree: true,
  characterData: true,
  childList: true
}
observer.observe(target, config)

noti = {}
noti.isDisplayedBadge = false
noti.changeTitle = (mutations) ->
  console.log mutations
  if !mutations
    isTarget = false
    return

  if mutations.length > 0
    title = mutations[0].target.data
    badgeNum = noti.badgeNum(title)
    if badgeNum < 1
      noti.resetBadge()
      return
    console.log 'match'
    noti.displayBadge(badgeNum)


noti.badgeNum = (str) ->
  m = str.match(/^\(([0-9]+)\)/)
  if m
    return Number(m[1])
  return -1

noti.displayBadge = (num) ->
  favicon.badge(num);

noti.resetBadge = () ->
  favicon.reset();








