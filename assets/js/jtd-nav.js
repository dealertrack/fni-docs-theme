// Rather than generating a new left-nav for every page, generate a single nav and use JS to expand the current page

(function (jtd) {

function initNavControls() {
  const siteNav = document.getElementById('site-nav')

  const pageUrl = siteNav.dataset.pageUrl
  const pageParent = siteNav.dataset.pageParent
  const pageGrandParent = siteNav.dataset.pageGrandParent

  console.log({pageUrl, pageParent, pageGrandParent})

  const navItems = siteNav.getElementsByClassName('nav-list-item')

  for (const navItem of navItems) {
    const itemUrl = navItem.dataset.url
    const itemTitle = navItem.dataset.title

    console.log({itemUrl, itemTitle})
    
    if (itemUrl === pageUrl || itemTitle === pageParent || itemTitle == pageGrandParent) {
      navItem.classList.add('active')
      navItem.querySelector('.nav-list-link').classList.add('active')

      navItem.scrollIntoView()
    }
  }
}

jtd.onReady(function(){
  initNavControls()
})

})(window.jtd)
