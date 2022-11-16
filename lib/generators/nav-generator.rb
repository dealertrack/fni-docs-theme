module NavGenerator
  class Generator < Jekyll::Generator
    # Generate a sorted page heirarchy based on parent / grand_parent
    # TODO: If a new page is added to the site, need to hook into incremental rebuild and flush nav.html cache
    def generate(site)
      nav = nav_for_parent(site.pages, nil, nil)
      
      # Attach nav data to the default layout
      site.layouts['default'].data['nav'] = nav
    end

    def nav_for_parent(page_list, parentPage, grandParentPage)
      parentPageTitle = parentPage && parentPage.data['title']
      pages = page_list
        .filter { |page| page.data['parent'] == parentPageTitle && page.data['title'] != nil && page.data['nav_exclude'] != true }
        .sort_by { |page| [page.data['nav_order'] || 999, page.data['title']] }  

      nav = pages.map { |page|
        children = page.data['has_children'] && nav_for_parent(page_list, page, parentPage)

        # Attach the child data to the page itself, used to render the footer Table of Contents
        page.data['children'] = children
        
        # Attach parent/grandparent URLs for rendering breadcrumb
        page.data['parent_url'] = parentPage&.url
        page.data['grand_parent_url'] = grandParentPage&.url
        
        {
          'title' => page.data['title'],
          'url' => page.url,
          'children' => children
        }
      }
    end
  end
end
