module Spree
  class HomeController < Spree::StoreController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @taxonomies = Spree::Taxonomy.includes(root: :children)
    end

    def about_us
    end
    def contact_us
    end
    def careers
    end
    def customer_service
    end
    def faqs
    end
    def shipping_delivery
    end
    def temrs_conditions
    end
    def privacy_policy
    end
    def return_cancellation
    end
    def price_guarantee
    end
  end
end
