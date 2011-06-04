module Tilt

  module MiddlemanBlogTemplate
    def prepare
      @data = data.gsub(/^.*?#{Middleman::Blog::SEPARATOR}/m, '')
      super
    end
  end


  # MARKDOWN

  class MarukuMiddlemanBlogTemplate < MarukuTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register MarukuMiddlemanBlogTemplate, 'markdown', 'mkd', 'md'

  class KramdownMiddlemanBlogTemplate < KramdownTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register KramdownMiddlemanBlogTemplate, 'markdown', 'mkd', 'md'

  class BlueClothMiddlemanBlogTemplate < BlueClothTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register BlueClothMiddlemanBlogTemplate, 'markdown', 'mkd', 'md'

  class RedcarpetMiddlemanBlogTemplate < RedcarpetTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register RedcarpetMiddlemanBlogTemplate, 'markdown', 'mkd', 'md'

  class RDiscountMiddlemanBlogTemplate < RDiscountTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register RDiscountMiddlemanBlogTemplate, 'markdown', 'mkd', 'md'

  # TEXTILE

  class RedClothMiddlemanBlogTemplate < RedClothTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register RedClothMiddlemanBlogTemplate, 'textile'

  # RDOC

  class RDocMiddlemanBlogTemplate < RDocTemplate
    include Tilt::MiddlemanBlogTemplate
  end
  register RDocMiddlemanBlogTemplate, 'rdoc'



end