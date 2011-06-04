module Middleman
  module Features
    module BlogEngine

      class << self
        def registered(app)
          app.helpers BlogEngine::Helpers
        end
        alias :included :registered
      end

      module Helpers
        def blog(blog_ident)
          blogs[blog_ident] || {"posts" => []}
        end
        def current_blog
          blog(current_blog_ident)
        end
        def blog_meta(blog_ident, key)
          blog(blog_ident)[key] || no_value
        end
        def current_blog_meta(key)
          blog_meta(current_blog_ident,key)
        end
        def blog_post(blog_ident, post_ident)
          blog(blog_ident)["posts"].find {|post| post["ident"] == post_ident } || {}
        end
        def current_post
          blog_post(current_blog_ident, current_post_ident)
        end
        def blog_post_meta(blog_ident, post_ident, key)
          blog_post(blog_ident, post_ident)[key] || blog_meta(blog_ident, key) || no_value
        end
        def current_post_meta(key)
          blog_post_meta(current_blog_ident, current_post_ident, key)
        end
        def next_post
          current_blog["posts"][current_post_index + 1]
        end
        def prev_post
          current_blog["posts"][current_post_index - 1]
        end
        def current_blog_ident
          (File.dirname request_path).gsub(%r{^/}, '') || "blog"
        end
        def current_post_ident
          File.basename(request_path).split(".", 2)[0]
        end
        def current_post_index
          current_blog["posts"].index current_post
        end

        def blogs
          Middleman::Features::BlogEngine::Meta.new(self).data
        end

        private
          def request_path
            self.env['REQUEST_PATH'] || ""
          end
          def no_value
            "-- no value --"
          end

      end

      class Meta
        attr_reader :data

        def initialize(app)
          @app = app

          config_file = File.join(@app.class.root, "config", "blogs.yml")
          raise "could not find \"#{config_file}\" " unless File.exists?(config_file)
          blog_config = YAML.load_file(config_file)
          @data = blog_config

          blog_config.each do |blog_ident,blog_values|
            blog_source_dir = File.join(@app.class.views, blog_ident)
            @data[blog_ident]["posts"] = []
            Dir["#{blog_source_dir}/*.html.*"].each do |file|
              if file =~ /.*\.html\.(markdown|mkd|md|textile|rdoc)$/
                post_ident = File.basename(file).split(".", 2)[0]

                post_meta_yml = ERB.new( (File.read(file).split(/#{Middleman::Blog::SEPARATOR}/, 2))[0] || "" ).result
                post_meta = YAML.load(post_meta_yml) || {}
                post_meta["ident"] = post_ident
                post_meta["link"] = "/%s" % File.join( blog_ident, File.basename(file, '.*') )
                post_meta["date"] = File.mtime(file).to_s unless post_meta["date"]
                @data[blog_ident]["posts"] << post_meta
              end
            end

            sort_key = @data[blog_ident]["sort_key"] || "date"
            @data[blog_ident]["posts"].sort_by! { |post| post[sort_key] }
            sort_direction = @data[blog_ident]["sort_direction"] || "reverse"
            @data[blog_ident]["posts"].reverse! if sort_direction == "reverse"
          end

        end

      end



    end
  end
end