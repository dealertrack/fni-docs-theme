
window.jtd.onReady(() => {
  initDiags()
})

async function initDiags() {
  const defaultWidth = 736
  const defaultHeight = 400

  const curPath = window.location.pathname
  const diags = document.getElementsByClassName('plantuml-diagram')

  for (const diag of diags) {
    const src = diag.dataset.diagramSrc
    const svgSrc = src.replace('.iuml', '.svg')
    const diagCont = diag.getElementsByClassName('plantuml-diagram-inner')[0]
    const viewCont = diag.getElementsByClassName('plantuml-diagram-open')[0]
    const width = diag.dataset.diagramWidth || defaultWidth
    const height = diag.dataset.diagramHeight || defaultHeight

    // Fetch the svg
    const svgRes = await fetch(curPath + svgSrc)
    if (!svgRes.ok) {
      diagCont.innerHTML = '<div class="error-msg">Failed to retrieve diagram</div>'
      continue
    }

    // Add an open button
    viewCont.innerHTML = `<a href="${svgSrc}" target="_blank" rel="noopener">open</a>`

    const svg = await svgRes.text()

    diagCont.innerHTML = svg
    const svgElement = diag.getElementsByTagName('svg')[0]

    svgElement.style.width = width
    svgElement.style.height = height
    svgElement.style.backgroundColor = '#333'

    const spz = svgPanZoom(svgElement, {
      zoomEnabled: true,
      controlIconsEnabled: false,
      fit: true,
      center: true,
      dblClickZoomEnabled: false,
      customEventsHandler: {
        init: options => {
          // Double click to toggle fullscreen
          options.svgElement.addEventListener('dblclick', () => {
            if (options.svgElement.style.position === 'fixed') {
              options.svgElement.style.position = null
              options.svgElement.style.left = null
              options.svgElement.style.top = null
              options.svgElement.style.zIndex = null
              options.svgElement.style.width = width
              options.svgElement.style.height = height
            } else {
              options.svgElement.style.position = 'fixed'
              options.svgElement.style.left = '20px'
              options.svgElement.style.top = '20px'
              options.svgElement.style.zIndex = '9999'
              options.svgElement.style.width = getWidth() - 40
              options.svgElement.style.height = getHeight() - 40
            }

            options.instance.updateBBox()
            options.instance.resize()
            options.instance.fit()
            options.instance.center()
          })
        }
      }
    })
  }
}

function getWidth() {
  return Math.max(
    document.body.scrollWidth,
    document.documentElement.scrollWidth,
    document.body.offsetWidth,
    document.documentElement.offsetWidth,
    document.documentElement.clientWidth
  );
}

function getHeight() {
  return Math.max(
    document.body.scrollHeight,
    document.documentElement.scrollHeight,
    document.body.offsetHeight,
    document.documentElement.offsetHeight,
    document.documentElement.clientHeight
  );
}
