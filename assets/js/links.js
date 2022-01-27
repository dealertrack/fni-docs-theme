
window.jtd.onReady(() => {
  externalLinks()
})

// Find all anchor links on the page that reference external pages or static files and open them in a new tab
function externalLinks() {
  const newTabExtensions = ['.pdf', '.png', '.svg']
  const links = document.getElementsByTagName('a')
  for (const link of links) {
    const href = link.getAttribute('href')
    if (href && link.hostname !== location.hostname) {
      link.target = "_blank";
      link.rel = "noopener";
    } else if (href && newTabExtensions.some(ext => href.indexOf(ext) > 0)) {
      link.onclick = function () {
        window.open(this.href)
        return false
      }
    }
  }
}
