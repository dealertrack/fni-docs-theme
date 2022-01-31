require 'uri'
require 'net/http'
require 'digest'

module PlantUmlConverterPlugin
  # Whitelists *.iuml documents for conversion despite them lacking front matter
  class PlantUmlGenerator < Jekyll::Generator
    attr_accessor :site
    safe true
    priority :low

    @plantuml_converter

    def initialize(site)
      @plantuml_converter = PlantUmlConverter.new()
    end

    def generate(site)
      diagrams = site.static_files.select { |file| @plantuml_converter.matches(static_file_ext(file)) }
      site.pages.concat(diagrams.map { |diag| page_from_static_file(site, diag) })
      site.static_files -= diagrams
    end

    def static_file_ext(static_file)
      static_file.extname
    end

    # Given a Jekyll::StaticFile, returns the file as a Jekyll::Page
    def page_from_static_file(site, static_file)
      base = static_file.instance_variable_get("@base")
      dir  = static_file.instance_variable_get("@dir")
      name = static_file.instance_variable_get("@name")
      Jekyll::Page.new(site, base, dir, name)
    end
  end

  class PlantUmlConverter < Jekyll::Converter
    safe true
    priority :low

    @config = {}

    def matches(ext)
      ext =~ /^\.iuml$/i
    end

    def output_ext(ext)
      '.svg'
    end

    def initialize(config = {})
      @config = config['plantuml']
    end

    def convert(content)
      dest_uri = URI("#{@config['server_uri']}/svg/")
      
      begin
        iuml = filter_iuml(content)
        svg_res = Net::HTTP.post(dest_uri, iuml, 'Content-Type' => 'text/plain')

        unless (svg_res.kind_of? Net::HTTPSuccess)
          diag_name = content.lines.first.sub('@startuml ','').sub("\n", '')
          error_msg = svg_res['X-PlantUML-Diagram-Error']
          error_line = svg_res['X-PlantUML-Diagram-Error-Line']
          Jekyll.logger.error "Failed to render .iuml [#{diag_name}]: #{error_msg} at line #{error_line}"
          return ''
        end

        svg_res.body
      rescue => err
        diag_name = content.lines.first.sub('@startuml ','').sub("\n", '')
        Jekyll.logger.error "Failed to convert IUML document: #{diag_name} - #{err.message}"
        return ''
      end
    end

    # Clean up markup as needed (matches)
    #    Add "!theme spacelab" if no theme present and set background color
    #    Add an @enduml that only seems to be needed for server rendering
    def filter_iuml(iuml)
      iuml_arr = iuml.split("\n")
      unless (iuml.include? '!theme')
        iuml_arr = iuml_arr.insert(1, '!theme spacelab')
      end
      unless (iuml.include? 'skinparam backgroundColor')
        iuml_arr = iuml_arr.insert(2, 'skinparam backgroundColor #333')
      end
      unless (iuml.include? '@enduml')
        iuml_arr = iuml_arr.push("@enduml")
      end
      iuml_arr.join("\n")
    end
  end

  # TODO: Could also define a custom plantuml liquid block instead of the include, would still need to inject scripts into <head>
  #   ref https://github.com/yegor256/jekyll-plantuml/blob/master/lib/jekyll-plantuml.rb
end
