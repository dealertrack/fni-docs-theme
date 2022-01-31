module NavGenerator
  class Generator < Jekyll::Generator
    # Generate a sorted page heirarchy based on parent / grand_parent
    # TODO: If a new page is added to the site, need to hook into incremental rebuild and flush nav.html cache
    def generate(site)
      nav = nav_for_parent(site.pages, nil)
      
      # Attach nav data to the default layout
      site.layouts['default'].data['nav'] = nav
    end

    def nav_for_parent(page_list, parent)
      pages = page_list
        .filter { |page| page.data['parent'] == parent && page.data['title'] != nil && page.data['nav_exclude'] != true }
        .sort_by { |page| [page.data['nav_order'] || 999, page.data['title']] }  

      nav = pages.map { |page|
        children = page.data['has_children'] && nav_for_parent(page_list, page.data['title'])

        # Attach the child data to the page itself, used to render the footer Table of Contents
        page.data['nav'] = children
        
        {
          'title' => page.data['title'],
          'url' => page.url,
          'children' => children
        }
      }
    end
  end
end
