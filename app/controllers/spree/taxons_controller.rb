module Spree
  class TaxonsController < Spree::StoreController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    helper 'spree/products'

    respond_to :html, :js

    def show
      @taxon = Spree::Taxon.friendly.find(params[:id])
      return unless @taxon
      if request.xhr?
        sorting_scope = params[:sorting].try(:to_sym)
        hash = {}
        @products = []
        @taxon.products.select{|pro| hash[pro.id] = pro.price.to_f}
        hash_array = params[:sorting] == "descend_by_master_price" ? hash.sort_by {|k,v| v}.reverse : hash.sort_by {|k,v| v}
        hash_array.each do |product|
          @taxon.products.select{|pro| @products << pro if pro.id == product[0]}
        end
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
