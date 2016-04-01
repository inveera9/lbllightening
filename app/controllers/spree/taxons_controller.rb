module Spree
  class TaxonsController < Spree::StoreController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    helper 'spree/products'

    respond_to :html, :js

    def show
      @sort_options = { 
          "Most Popular" => "descend_by_popularity", 
          "Name: A to Z" => "ascend_by_name", 
          "Name: Z to A" => "descend_by_name", 
          "Price: High to Low" => "descend_by_master_price", 
          "Price: Low to High" => "ascend_by_master_price", 
      }
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon
      if request.xhr?
        byebug
        sorting_scope = params[:sorting].try(:to_sym)
        @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
        @products = @searcher.retrieve_products.send(sorting_scope)
        @taxonomies = Spree::Taxonomy.includes(root: :children)
        respond_to do |format| 
          format.js
        end
      else
        @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
        @products = @searcher.retrieve_products
        @taxonomies = Spree::Taxonomy.includes(root: :children)
      end
    end

    private

    def accurate_title
      if @taxon
        @taxon.seo_title
      else
        super
      end
    end

  end
end
