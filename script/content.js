// Generated by CoffeeScript 1.6.3
(function() {
  var config, favicon, isTarget, newImg, noti, observer, target;

  favicon = null;

  isTarget = true;

  newImg = null;

  favicon = new Favico({
    animation: 'fade',
    notification: 'jump'
  });

  favicon.badge(0);

  target = document.getElementsByTagName('title')[0];

  observer = new WebKitMutationObserver(function(mutations) {
    if (isTarget) {
      return noti.changeTitle(mutations);
    }
  });

  config = {
    subtree: true,
    characterData: true,
    childList: true
  };

  observer.observe(target, config);

  noti = {};

  noti.isDisplayedBadge = false;

  noti.changeTitle = function(mutations) {
    var badgeNum, title;
    console.log(mutations);
    if (!mutations) {
      isTarget = false;
      return;
    }
    if (mutations.length > 0) {
      title = mutations[0].target.data;
      badgeNum = noti.badgeNum(title);
      if (badgeNum < 1) {
        noti.resetBadge();
        return;
      }
      console.log('match');
      return noti.displayBadge(badgeNum);
    }
  };

  noti.badgeNum = function(str) {
    var m;
    m = str.match(/^\(([0-9]+)\)/);
    if (m) {
      return Number(m[1]);
    }
    return -1;
  };

  noti.displayBadge = function(num) {
    return favicon.badge(num);
  };

  noti.resetBadge = function() {
    return favicon.reset();
  };

}).call(this);
